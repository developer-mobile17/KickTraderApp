//
//  SellerEarningDetailCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerEarningDetailCell: UITableViewCell {
    @IBOutlet var lblOrderTitle: UILabel!
    @IBOutlet var lblOrderDate: UILabel!
    @IBOutlet var lblOrderPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
