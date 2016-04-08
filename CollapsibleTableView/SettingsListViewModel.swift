//
//  SettingsListViewModel.swift
//  CollapsibleTableView
//
//  Created by Andrei Balasanu on 4/8/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import Foundation


class SettingsListViewModel: NSObject {
    private var settings: [SettingViewModel]
    private var flatSettings: [SettingViewModel]

    override init() {
        let models = [
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
        settings = models.map{ SettingViewModel(setting: $0) }
        flatSettings = settings
    }

    func numberOfSettings() -> Int {
        return flatSettings.count
    }

    func settingAtIndex(index: Int) -> SettingViewModel {
        return flatSettings[index]
    }

    func toogleExpansionStatusOfSettingAtIndex(index: Int) {
        let setting = settingAtIndex(index)
        setting.expanded = !setting.expanded
    }

    func reloadSettings() -> ArrayDiff {
        let oldFlatSettings = flatSettings
        flatSettings = settings.flatMap{ $0.flatSettings() }
        return diff(oldFlatSettings, other: flatSettings)
    }
}

private extension SettingViewModel {
    func flatSettings() -> [SettingViewModel] {
        let expandedSubsettings = expanded ? subsettings : [SettingViewModel]()
        return [self] + expandedSubsettings.flatMap { $0.flatSettings() }
    }
}