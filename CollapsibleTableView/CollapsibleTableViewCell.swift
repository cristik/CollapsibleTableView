//
//  CollapsibleTableViewCell.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 29/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewCellDataSource {
    func title() -> String
    func indentationLevel() -> Int
}

class CollapsibleTableViewCell: UITableViewCell {
    func configure(dataSource: CollapsibleTableViewCellDataSource) {
        selectionStyle = .None
        textLabel?.text = dataSource.title()
        indentationWidth = 20
        indentationLevel = dataSource.indentationLevel()
    }
}
