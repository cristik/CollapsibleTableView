//
//  MasterViewController.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 23/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

class CollapsibleTableViewController: UITableViewController {

    var settings  = [
        Setting(name:"General", subsettings: [
            Setting(name:"Appearance")]),
        Setting(name: "Account", subsettings: [
            Setting(name: "Profile"),
            Setting(name: "Password"),
            Setting(name: "Other")]),
        Setting(name: "Favorites", subsettings: [
            Setting(name: "Manage")]
        )
        ].map { SettingViewModel(setting: $0) }

    // flat list of visible settings, for the table view data source
    var actualSettings = [SettingViewModel]()

    func reloadData() {
        let previousSettings = actualSettings
        actualSettings = settings.flatMap{ $0.flatSettings() }

        let diffe = diff(previousSettings, other: actualSettings)
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths(diffe.added.map { NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .Automatic)
        tableView.deleteRowsAtIndexPaths(diffe.deleted.map { NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .Automatic)
        tableView.endUpdates()
    }

    var detailViewController: DetailViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        actualSettings = settings

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        // TODO: view model holding the cell class, in case we have two types of cells
        // TODO: awesome registration from articles, with enums
        tableView.registerClass(CollapsibleTableViewCell.self, forCellReuseIdentifier: "CollapsibleTableViewCell")
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actualSettings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("CollapsibleTableViewCell", forIndexPath: indexPath) as? CollapsibleTableViewCell) ?? CollapsibleTableViewCell()
        cell.configure(actualSettings[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        actualSettings[indexPath.row].toggleExpansionStatus()
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
