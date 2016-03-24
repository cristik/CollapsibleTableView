//
//  MasterViewController.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 23/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let subsettings: [Setting]
    
    init(name: String, subsettings: [Setting] = []) {
        self.name = name
        self.subsettings = subsettings
    }
}

class CollapsibleTableViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var settings = [
        Setting(name:"General", subsettings: [
            Setting(name:"Appearance")]),
        Setting(name: "Account", subsettings: [
            Setting(name: "Profile"),
            Setting(name: "Password"),
            Setting(name: "Other")]),
        Setting(name: "Favorites", subsettings: [
            Setting(name: "Manage")]
        )
    ]
    
    // workaround
    var expandedSettings = [Setting]()
    var actualSettings = [Setting]()

    override func viewDidLoad() {
        super.viewDidLoad()
        actualSettings = settings;
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    func reloadData() {
        let previousSettings = actualSettings
        actualSettings = settings.reduce([Setting]()) {
            var result = $0
            result.append($1)
            if expandedSettings.indexOf($1) != nil {
                result.appendContentsOf($1.subsettings)
            }
            return result
        }
        let diffe = diff(previousSettings, other: actualSettings)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths(diffe.added.map { NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .Automatic)
        tableView.deleteRowsAtIndexPaths(diffe.deleted.map { NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .Automatic)
        tableView.endUpdates()
        //tableView.reloadData()
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualSettings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.selectionStyle = .None;
        
        let setting = actualSettings[indexPath.row]
        cell.textLabel!.text = setting.name
        if setting.subsettings.count == 0 {
            var insets = cell.layoutMargins
            insets.left = 50
            cell.layoutMargins = insets
        } else {
            var insets = cell.layoutMargins
            insets.left = 0
            cell.layoutMargins = insets
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let setting = actualSettings[indexPath.row]
        if let idx = expandedSettings.indexOf(setting) {
            expandedSettings.removeAtIndex(idx)
        } else {
            expandedSettings.append(setting);
        }
        reloadData()
    }

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        if segue.identifier == "showDetail" {
        //            if let indexPath = self.tableView.indexPathForSelectedRow {
        //                let object = settings[indexPath.row] as! NSDate
        //                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        //                controller.detailItem = object
        //                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        //                controller.navigationItem.leftItemsSupplementBackButton = true
        //            }
        //        }
    }
}


func diff<Element>(array: [Element], other: [Element], equals: (Element, Element) -> Bool) -> (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)]) {
    var added: [Int] = []
    var deleted: [Int] = []
    var moved: [(from: Int, to: Int)] = []
    for (i, item) in array.enumerate() {
        if let j = other.indexOf({equals($0, item)}) {
            if i != j {
                moved.append((from: i, to: j))
            }
        } else {
            deleted.append(i)
        }
    }
    for (i, item) in other.enumerate() {
        if array.indexOf({equals($0, item)}) == nil {
            added.append(i)
        }
    }
    return (added: added, deleted: deleted, moved: moved)
}


func diff<Element: Equatable>(array: [Element], other: [Element]) -> (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)]) {
    return diff(array, other: other, equals: ==)
}


//func diff<Element: AnyObject>(array: [Element], array: [Element], other: [Element]) -> (added: [Int], deleted: [Int], moved: [(from: Int, to: Int)]) {
//    return diff(array, other: other, equals: ===)
//}

