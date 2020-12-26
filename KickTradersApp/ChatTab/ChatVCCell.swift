//
//  ChatVCCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 17/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ChatVCCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
