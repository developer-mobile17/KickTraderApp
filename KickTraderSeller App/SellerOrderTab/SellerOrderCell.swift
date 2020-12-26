//
//  SellerOrderCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 04/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerOrderCell: UITableViewCell {
    
        @IBOutlet var imgShoes: UIImageView!
        @IBOutlet var lblBrandName: UILabel!
        @IBOutlet var lblShoeName: UILabel!
        @IBOutlet var lblSize: UILabel!
        @IBOutlet var lblColor: UILabel!
        @IBOutlet var lblBidprice: UILabel!
        @IBOutlet var lblOrderStatus: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
       lblColor.layer.cornerRadius = 5
       lblColor.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
