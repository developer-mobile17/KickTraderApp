//
//  SellerProductColorCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/02/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class SellerProductColorCell: UITableViewCell {
    @IBOutlet var sellerProductColorCollection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func reloadSellerProductColorCC() -> Void{
        self.sellerProductColorCollection.reloadData()

    }

}

extension SellerProductColorCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSellerProductColor.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SizeCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "SellerProductColorCollectionCell", for: indexPath) as! SellerProductColorCollectionCell

        let colorDataModel = arrSellerProductColor[indexPath.row]

        SizeCollection.lblColorOfShoe.backgroundColor =  UIColor(hexFromString:colorDataModel.colorCode!)
        SizeCollection.lblColorOfShoe.layer.cornerRadius = 7
        SizeCollection.lblColorOfShoe.clipsToBounds = true


        return SizeCollection
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!SellerProductColorCollectionCell

        CCell.isSelected = true
        CCell.layer.borderColor = UIColor.black.cgColor
        CCell.layer.borderWidth = 2
        CCell.layer.cornerRadius = 5

        let arrSelecetSize = arrSellerProductColor[indexPath.row].size!
        if let data = try? PropertyListEncoder().encode(arrSelecetSize) {

            UserDefaults.standard.set(data, forKey: "SavedItemArray")

        }

        NotificationCenter.default.post(name: Notification.Name(rawValue: "checkSize"), object: self)

        //TODO:- Logic to change image using Color select.
        let arrSellerChooseColor = arrSellerProductColor[indexPath.row].image!
        let slideIMGpass = arrSellerChooseColor.map({$0.imageName!})
        print(slideIMGpass)


        let defaultsSlider = UserDefaults.standard
        defaultsSlider.setValue(slideIMGpass,forKey: "imgPass")

        NotificationCenter.default.post(name: Notification.Name(rawValue: "check"), object: self)



        //TODO:- Pass ColorRef to Another ViewController
//        print("COlorProductRef:",arrProductColor[indexPath.row].coloToProductRef!)
//        let defaults = UserDefaults.standard
//        defaults.setValue(arrProductColor[indexPath.row].coloToProductRef, forKey: "DefaultscoloToProductRef")

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!SellerProductColorCollectionCell
        CCell.layer.backgroundColor = UIColor.clear.cgColor
        CCell.layer.borderColor = UIColor.clear.cgColor

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42 , height: 42)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }


}
