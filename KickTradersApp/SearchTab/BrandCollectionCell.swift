//
//  BrandCollectionCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class BrandCollectionCell: UICollectionViewCell {
     @IBOutlet var imgBrands: UIImageView!
     @IBOutlet var lblBrandName: UILabel!


    func toggleBrandSelected ()
           {
            if (isSelected){
                imgBrands.layer.cornerRadius = 10
                imgBrands.clipsToBounds = true
                imgBrands.layer.borderWidth = 3
                imgBrands.layer.borderColor = UIColor.red.cgColor
                //cellCheckMarkImage.image = UIImage(imageLiteralResourceName: "checkmark.circle.fill")

               // backgroundColor = .red
               }else {


               }
           }


}
