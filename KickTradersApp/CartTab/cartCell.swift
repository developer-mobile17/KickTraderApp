//
//  cartCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class cartCell: UITableViewCell {
    
    
     @IBOutlet var btnBuyOrPlaceBid: UIButton!
     @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnAddToFavourite: UIButton!
     @IBOutlet var imgShoes: UIImageView!
     @IBOutlet var lblShoeName: UILabel!
     @IBOutlet var lblSize: UILabel!
     @IBOutlet var lblColor: UILabel!
     @IBOutlet var lblBidPrice: UILabel!
     @IBOutlet var lblProductPrice: UILabel!
     @IBOutlet var lblStatus: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        lblColor.layer.cornerRadius = 5
        lblColor.clipsToBounds = true
        
        // Configure the view for the selected state
    }

}
