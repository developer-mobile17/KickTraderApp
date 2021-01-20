//
//  ProductSizeCollectionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 26/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ProductSizeCollectionCell: UICollectionViewCell {
    
    @IBOutlet var lblSize: UILabel!

    func toggleSizeSelected() {

        if (isSelected) {

            lblSize.layer.cornerRadius = lblSize.bounds.height/2
            lblSize.layer.backgroundColor = UIColor.black.cgColor
            
        }

        else {
            lblSize.cornerRadius = 0
            lblSize.layer.backgroundColor = UIColor.clear.cgColor
        }

    }
    
    
}

