//
//  ProductColorCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 26/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ProductColorCell: UITableViewCell {
    
    @IBOutlet var objCollectionProductColor : UICollectionView!
   
    
   // var arrSelectedCOlor = [arrProductColor]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func reloadProductColorCC() -> Void{
        self.objCollectionProductColor.reloadData()
        
    }
    
}

extension ProductColorCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductColor.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SizeCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductColorCollectionCell", for: indexPath) as! ProductColorCollectionCell
        
        let colorDataModel = arrProductColor[indexPath.row]
        
        SizeCollection.lblColor.backgroundColor =  UIColor(hexFromString:colorDataModel.colorCode!)
        SizeCollection.lblColor.layer.cornerRadius = 7
        SizeCollection.lblColor.clipsToBounds = true
        
        
        return SizeCollection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!ProductColorCollectionCell

        CCell.isSelected = true
        CCell.layer.borderColor = UIColor.black.cgColor
        CCell.layer.borderWidth = 2
        CCell.layer.cornerRadius = 5

        let arrSelecetSize = arrProductColor[indexPath.row].size!
        if let data = try? PropertyListEncoder().encode(arrSelecetSize) {
            
            UserDefaults.standard.set(data, forKey: "SavedItemArray")
            
        }
        

        NotificationCenter.default.post(name: Notification.Name(rawValue: "checkSize"), object: self)

        //TODO:- Logic to change image using Color select.
        let arrChooseColor = arrProductColor[indexPath.row].image!
        let slideIMGpass = arrChooseColor.map({$0.imageName!})
        print(slideIMGpass)


        let defaultsSlider = UserDefaults.standard
        defaultsSlider.setValue(slideIMGpass, forKey: "imgPass")

        NotificationCenter.default.post(name: Notification.Name(rawValue: "check"), object: self)
        


        //TODO:- Pass ColorRef to Another ViewController
        print("COlorProductRef:",arrProductColor[indexPath.row].coloToProductRef!)
        let defaults = UserDefaults.standard
        defaults.setValue(arrProductColor[indexPath.row].coloToProductRef, forKey: "DefaultscoloToProductRef")
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!ProductColorCollectionCell
        CCell.layer.backgroundColor = UIColor.clear.cgColor
        CCell.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 32 , height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
