//
//  TransactionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
     @IBOutlet var imgShoes: UIImageView!
     @IBOutlet var lblShoeBrandName: UILabel!
     @IBOutlet var lblShoeName: UILabel!
     @IBOutlet var lblSize: UILabel!
     @IBOutlet var lblColor: UILabel!
     @IBOutlet var lblPrice: UILabel!
     @IBOutlet var lblDate: UILabel!
     @IBOutlet var lblStatus: UILabel!
     @IBOutlet var btnAddRating: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
