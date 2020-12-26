//
//  AddressListCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class AddressListCell: UITableViewCell {
    
    
    @IBOutlet var lblfullName: UILabel!
    @IBOutlet var lblmobile: UILabel!
    @IBOutlet var lbladdress: UILabel!
    @IBOutlet var lblcity: UILabel!
    @IBOutlet var lblstate: UILabel!
    @IBOutlet var lblZipCode: UILabel!
    
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var btnSelect: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
