//
//  HomeCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
class HomeCell: UITableViewCell {
  @IBOutlet var btnFavourite: UIButton!
  @IBOutlet var lblPrice: UILabel!
  @IBOutlet var imgShoes: UIImageView!
 
  @IBOutlet var lblShoeName: UILabel!
  @IBOutlet var vwStarRating: FloatRatingView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
