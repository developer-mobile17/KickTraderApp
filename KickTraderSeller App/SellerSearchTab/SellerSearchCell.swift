//
//  SellerSearchCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerSearchCell: UITableViewCell {
    
     @IBOutlet var imgShoes: UIImageView!
     @IBOutlet var lblBrandName: UILabel!
     @IBOutlet var lblShoeName: UILabel!
     @IBOutlet var lblPrice: UILabel!
    
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var btnDelete: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   

}
