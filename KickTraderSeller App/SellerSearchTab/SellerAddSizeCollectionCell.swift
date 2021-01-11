//
//  SellerAddSizeCollectionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerAddSizeCollectionCell: UICollectionViewCell {
    
    @IBOutlet var lblSize: UILabel?
    
    func AddSizetoggleSelected ()
    {
        if (isSelected)
        {
            
            lblSize!.layer.cornerRadius = lblSize!.bounds.height/2
            lblSize!.layer.backgroundColor = UIColor.black.cgColor
        }
        else
        {
            lblSize!.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
}
