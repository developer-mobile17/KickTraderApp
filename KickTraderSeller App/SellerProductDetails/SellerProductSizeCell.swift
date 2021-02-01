//
//  SellerProductSizeCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/02/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class SellerProductSizeCell: UITableViewCell {
    @IBOutlet var sellerProductSizeCollection: UICollectionView!
    var arrPassSellerSize = [arrSellerShoeSize]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reloadSellerProductSizeCC() -> Void {
        sellerProductSizeCollection.layer.cornerRadius = 10
        self.sellerProductSizeCollection.reloadData()


        NotificationCenter.default.addObserver(self, selector: #selector(DidColorTapForSize), name: Notification.Name(rawValue: "checkSize"), object: nil)

  }


    @objc func DidColorTapForSize()
    {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "SavedItemArray") {
            arrSellerShoeSize = try! PropertyListDecoder().decode([SellerSIze].self, from: data)

        }
        self.sellerProductSizeCollection.reloadData()
    }

}


extension SellerProductSizeCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return arrSellerShoeSize.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SizeCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "SellerProductSizeCollectionCell", for: indexPath) as! SellerProductSizeCollectionCell


        let SellerProductsizeDataModel = arrSellerShoeSize[indexPath.row]
        SizeCollection.lblSizeOfShoe.text = SellerProductsizeDataModel.sizeName!

        return SizeCollection
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
//        let cell = collectionView.cellForItem(at: indexPath) as! ProductSizeCollectionCell
//        cell.isSelected = true
//        strSelectedSizeCheck = ""
//        cell.toggleSizeSelected()
//
//        let defaults = UserDefaults.standard
//        defaults.setValue(arrSize[indexPath.row].sizeToColorRef, forKey: "DefaultssizeToColorRef")
//
//
//    }

//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ProductSizeCollectionCell
//        cell.isSelected = false
//        cell.toggleSizeSelected()
//    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              return CGSize(width: 42 , height: 42)
          }

          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
              return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
          }


}
