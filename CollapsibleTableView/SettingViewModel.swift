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

    var title: String = ""
    var image: UIImage?
    var subsettings: [SettingViewModel] = []

    var expanded: Bool = false
    var indentationLevel: Int = 0

    init(setting: Setting, indentationLevel: Int = 0) {
        self.setting = setting
        self.title = setting.name
        self.indentationLevel = indentationLevel

        if let imageName = setting.imageName {
            image = UIImage(named: imageName)
        }

        subsettings = setting.subsettings.map {
            SettingViewModel(setting: $0, indentationLevel: indentationLevel + 1)
        }
    }
}