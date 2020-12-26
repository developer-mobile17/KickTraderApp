//
//  BiddingDetailsCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 04/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class BiddingDetailsCell: UITableViewCell {
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblBidPrice: UILabel!
    
    @IBOutlet var btnAcceptBid: UIButton!
    @IBOutlet var btnRejectBid: UIButton!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
