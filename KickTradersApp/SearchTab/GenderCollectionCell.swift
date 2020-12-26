//
//  GenderCollectionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class GenderCollectionCell: UICollectionViewCell {
    @IBOutlet var lblGender : UILabel!
    
    
    func toggleSelected ()
           {
            if (isSelected){
                //cellCheckMarkImage.image = UIImage(imageLiteralResourceName: "checkmark.circle.fill")
                lblGender.backgroundColor = UIColor.black
               // backgroundColor = .red
               }else {
               // backgroundColor = .white
               // self.cellCheckMarkImage.isHidden = true
                lblGender.backgroundColor =  UIColor.red
               }
           }
    
}
