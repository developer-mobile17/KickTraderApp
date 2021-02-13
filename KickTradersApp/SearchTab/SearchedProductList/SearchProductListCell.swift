//
//  SearchProductListCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/02/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class SearchProductListCell: UITableViewCell {
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
