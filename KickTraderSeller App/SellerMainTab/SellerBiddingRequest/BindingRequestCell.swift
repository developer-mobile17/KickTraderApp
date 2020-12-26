//
//  BindingRequestCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 04/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class BindingRequestCell: UITableViewCell {
    
    @IBOutlet var imgShoes: UIImageView!
    @IBOutlet var lblShoeName: UILabel!
    @IBOutlet var lblShoeBrandName: UILabel!
    @IBOutlet var lblShoeSize: UILabel!
    @IBOutlet var lblShoeColor: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblbidCount: UILabel!
    @IBOutlet var btnViewBids: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
