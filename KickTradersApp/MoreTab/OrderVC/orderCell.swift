//
//  orderCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 31/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class orderCell: UITableViewCell {
    
        @IBOutlet var imgShoes: UIImageView!
        @IBOutlet var lblShoeName: UILabel!
        @IBOutlet var lblSize: UILabel!
        @IBOutlet var lblColor: UILabel!
        @IBOutlet var lblPrice: UILabel!
        @IBOutlet var lblDate: UILabel!
       
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
