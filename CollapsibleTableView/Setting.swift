//
//  Setting.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 29/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: String
    let imageName: String?
    let subsettings: [Setting]
    
    init(name: String, imageName: String? = .None, subsettings: [Setting] = []) {
        self.name = name
        self.imageName = imageName
        self.subsettings = subsettings
    }
}


enum Setting2 {
    typealias Info = (name: String, imageUrl: String?)
    case Leaf(info: Info)
    case Node(info: Info, subsettings: [Setting2])
}