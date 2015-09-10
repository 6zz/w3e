//
//  MsgCell.swift
//  chat
//
//  Created by Shawn Zhu on 9/9/15.
//  Copyright (c) 2015 Shawn Zhu. All rights reserved.
//

import UIKit

class MsgCell: UITableViewCell {
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var msg : ParseMsg! {
        didSet {
            msgLabel.text = msg.text
            userLabel.text = msg.user
        }
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
