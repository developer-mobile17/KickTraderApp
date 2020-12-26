//
//  ColorCollectionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ColorCollectionCell: UICollectionViewCell {
    @IBOutlet var lblcolorBG: UILabel!
    @IBOutlet var cellCheckMarkImage: UIImageView!
    
    func toggleSelected ()
           {
            if (isSelected){
                //cellCheckMarkImage.image = UIImage(imageLiteralResourceName: "checkmark.circle.fill")
                self.cellCheckMarkImage.isHidden = false
               // backgroundColor = .red
               }else {
                backgroundColor = .white
                self.cellCheckMarkImage.isHidden = true
               }
           }
    
}

