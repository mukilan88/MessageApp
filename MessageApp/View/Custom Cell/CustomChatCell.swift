//
//  CustomChatCell.swift
//  MessageApp
//
//  Created by user146304 on 12/7/18.
//  Copyright © 2018 Voflic. All rights reserved.
//

import UIKit

class CustomChatCell: UITableViewCell {

    @IBOutlet weak var ChatBG: UIView!
    @IBOutlet weak var chat: UILabel!
    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var uImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
