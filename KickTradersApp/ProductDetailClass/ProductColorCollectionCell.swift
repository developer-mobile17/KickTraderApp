//
//  ProductColorCollectionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 26/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}

class ProductColorCollectionCell: UICollectionViewCell {
 
     @IBOutlet var lblColor: UILabel!
    
    func toggleColorSelection() {
        if (isSelected) {
            lblColor.borderColor = UIColor.black
            lblColor.textDropShadow()
            lblColor.borderWidth = 3
        }

        else {
            lblColor.borderColor = UIColor.white
            lblColor.textDropShadow()
            lblColor.borderWidth = 3
            
        }
    }
    
    
}
