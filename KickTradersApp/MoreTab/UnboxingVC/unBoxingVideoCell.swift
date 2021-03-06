//
//  unBoxingVideoCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class unBoxingVideoCell: UITableViewCell {
    
    @IBOutlet var imgShoes: UIImageView!
    @IBOutlet var lblBrandName: UILabel!
    @IBOutlet var lblShoeName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var vwStarRating: FloatRatingView!
    
    @IBOutlet var btnVideoPlayClicked : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
