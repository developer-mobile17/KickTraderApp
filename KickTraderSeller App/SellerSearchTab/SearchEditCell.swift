//
//  SearchEditCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 09/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SearchEditCell: UITableViewCell {
    
    @IBOutlet var imgShoes: UIImageView!
    @IBOutlet var lblproductColor: UILabel!
    @IBOutlet var lblproductSize: UILabel!
    @IBOutlet var btnEdit: UIButton!
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
