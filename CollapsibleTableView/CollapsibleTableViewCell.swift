//
//  CollapsibleTableViewCell.swift
//  CollapsibleTableView
//
//  Created by Cristian Kocza on 29/03/16.
//  Copyright © 2016 Cristik. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {
    

    func configure(viewModel: SettingViewModel) {
        selectionStyle = .None
        textLabel?.text = viewModel.title
        indentationWidth = 20
        indentationLevel = viewModel.indentationLevel
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
