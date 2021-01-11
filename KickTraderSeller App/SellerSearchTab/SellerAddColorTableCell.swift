//
//  SellerAddColorTableCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerAddColorTableCell: UITableViewCell {

    @IBOutlet var objCollectionColor: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadSellerAddColor() -> Void {
        objCollectionColor.layer.cornerRadius = 10
        self.objCollectionColor.reloadData()
        
    }

}


extension SellerAddColorTableCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  arrAddcolor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SizeCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "SellerAddColorCollectionCell", for: indexPath) as! SellerAddColorCollectionCell
        
        
        let sizeDataModel = arrAddcolor[indexPath.row]
        SizeCollection.lblColor.backgroundColor = UIColor(hexFromString:sizeDataModel.colorCode!)
        
        return SizeCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!SellerAddColorCollectionCell
        
        let defaultsAddColor = UserDefaults.standard
        defaultsAddColor.setValue(arrAddcolor[indexPath.row].colorRef, forKey: "DefaultsAddColorRef")
        
        CCell.isSelected = true
        CCell.layer.cornerRadius = 5
        CCell.layer.borderWidth = 2
        CCell.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!SellerAddColorCollectionCell
        CCell.layer.backgroundColor = UIColor.clear.cgColor
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              return CGSize(width: 38 , height: 38)
          }
          
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
              return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
          }

    
    
}

