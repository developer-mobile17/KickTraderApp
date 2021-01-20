//
//  ReceiverChatCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class ReceiverChatCell: UITableViewCell {
    @IBOutlet var lblReceiverTextMessage: UILabel!
    @IBOutlet var imgReceiverChat: UIImageView!
    
    @IBOutlet var lblReceiverDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
