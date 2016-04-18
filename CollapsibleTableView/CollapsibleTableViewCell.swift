//
//  CollapsibleTableViewCell.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 29/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {

    func configure(title: String, image: UIImage? = nil, indentationLevel: Int = 0) {
        selectionStyle = .None
        textLabel?.text = title
        imageView?.image = image
        indentationWidth = 20
        self.indentationLevel = indentationLevel
    }

}

extension CollapsibleTableViewCell {

    func configure(viewModel: SettingViewModel) {
        configure(viewModel.title, image: viewModel.image,
                  indentationLevel: viewModel.indentationLevel)
    }
}
