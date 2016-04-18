//
//  SettingsViewModel.swift
//  CollapsibleTableView
//
//  Created by Andrei Balasanu on 4/4/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

struct SettingViewModel: Equatable {
    let setting: Setting
    var _indentationLevel: Int = 0
    var expanded: Bool = false

    init(setting: Setting, indentationLevel: Int = 0) {
        self.setting = setting
        self._indentationLevel = indentationLevel
    }

    func flatSettings() -> [SettingViewModel] {
        let expandedSubsettings = expanded ? setting.subsettings.map { SettingViewModel(setting: $0, indentationLevel: _indentationLevel + 1) } : [SettingViewModel]()
        return [self] + expandedSubsettings.flatMap { $0.flatSettings() }
    }

    mutating func toggleExpansionStatus() {
        expanded = !expanded
    }
}

func ==(lhs: SettingViewModel, rhs: SettingViewModel) -> Bool {
    return lhs.setting === rhs.setting
}

extension SettingViewModel: CollapsibleTableViewCellDataSource {
    func title() -> String {
        return setting.name
    }
        
    func indentationLevel() -> Int {
        return _indentationLevel
    }
}