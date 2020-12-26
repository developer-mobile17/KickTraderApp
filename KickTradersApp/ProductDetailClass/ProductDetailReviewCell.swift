//
//  ProductDetailReviewCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 18/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ProductDetailReviewCell: UITableViewCell {
    
    @IBOutlet var lblUsername : UILabel!
    @IBOutlet var lblReviewDate : UILabel!
    @IBOutlet var lblReviewDesc : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
