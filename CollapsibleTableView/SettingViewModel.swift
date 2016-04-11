//
//  SettingsViewModel.swift
//  CollapsibleTableView
//
//  Created by Andrei Balasanu on 4/4/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

class SettingViewModel: NSObject {
    let setting: Setting

    var title: String {
        return setting.name
    }
    var image: UIImage? {
        return UIImage(named: setting.imageName ?? "")
    }
    var subsettings = [SettingViewModel]()
    var expanded: Bool = false {
        didSet {
            subsettings = expanded ? setting.subsettings.map{ SettingViewModel(setting: $0, indentationLevel: self.indentationLevel+1) } : []
        }
    }
    var indentationLevel: Int = 0

    init(setting: Setting, indentationLevel: Int = 0) {
        self.setting = setting
        self.indentationLevel = indentationLevel
    }

    func flatSettings() -> [SettingViewModel] {
        let expandedSubsettings = expanded ? subsettings : [SettingViewModel]()
        return [self] + expandedSubsettings.flatMap { $0.flatSettings() }
    }

    func toggleExpansionStatus() {
        expanded = !expanded
    }
}

extension SettingViewModel {
    var collapsibleTableViewCellModel: CollapsibleTableViewCellViewModel {
        return (title: title, indentationLevel: indentationLevel)
    }
}