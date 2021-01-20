//
//  ProductSizeCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 26/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ProductSizeCell: UITableViewCell {
    
    @IBOutlet var ShowProductSizeCollection: UICollectionView!
    var arrPassSize = [arrSize]
    var strSelectedSizeCheck: String!
    var indexCheck: NSInteger!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    func reloadProductSizeCC() -> Void {
        ShowProductSizeCollection.layer.cornerRadius = 10
        self.ShowProductSizeCollection.reloadData()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(DidColorTapForSize), name: Notification.Name(rawValue: "checkSize"), object: nil)
        
    }
    
    
    @objc func DidColorTapForSize()
    {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "SavedItemArray") {
            arrSize = try! PropertyListDecoder().decode([SIze].self, from: data)

        }
        self.ShowProductSizeCollection.reloadData()
    }
    
}


extension ProductSizeCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrSize.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SizeCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSizeCollectionCell", for: indexPath) as! ProductSizeCollectionCell


        let sizeDataModel = arrSize[indexPath.row]
        SizeCollection.lblSize.text = sizeDataModel.sizeName!

        if strSelectedSizeCheck ==  sizeDataModel.sizeName!
        {
            indexCheck = indexPath.row
            SizeCollection.lblSize.layer.cornerRadius = SizeCollection.lblSize.bounds.height/2
            SizeCollection.lblSize.layer.backgroundColor = UIColor.black.cgColor
        }
        else{
            SizeCollection.lblSize.cornerRadius = 0
            SizeCollection.lblSize.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        return SizeCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        let cell = collectionView.cellForItem(at: indexPath) as! ProductSizeCollectionCell
        cell.isSelected = true
        strSelectedSizeCheck = ""
        cell.toggleSizeSelected()

        let defaults = UserDefaults.standard
        defaults.setValue(arrSize[indexPath.row].sizeToColorRef, forKey: "DefaultssizeToColorRef")

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProductSizeCollectionCell
        cell.isSelected = false
        cell.toggleSizeSelected()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              return CGSize(width: 32 , height: 32)
          }
          
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
              return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
          }

    
    
}
