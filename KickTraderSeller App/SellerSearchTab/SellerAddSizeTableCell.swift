//
//  SellerAddSizeTableCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerAddSizeTableCell: UITableViewCell {
    
    @IBOutlet var objCollectionSize: UICollectionView!
    
    var arrAddSizeSelected = [Int]()
    
    var selectedSize = [String]()
    var selectedSizePass = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        objCollectionSize.allowsMultipleSelection = true
        
        // Initialization code
    }
    
    func reloadSellerAddSize() -> Void {
        objCollectionSize.layer.cornerRadius = 10
        self.objCollectionSize.reloadData()
        
    }
    
}

extension SellerAddSizeTableCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrAddsize.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let SizeCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "SellerAddSizeCollectionCell", for: indexPath) as! SellerAddSizeCollectionCell 
        
        
        let sizeDataModel = arrAddsize[indexPath.row]
        
        
        if arrAddSizeSelected.contains(indexPath.row) {
            
            SizeCollection.lblSize?.cornerRadius = SizeCollection.lblSize!.bounds.height/2
            SizeCollection.lblSize?.layer.backgroundColor = UIColor.black.cgColor
            
        }
        else{
            
            SizeCollection.lblSize?.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        SizeCollection.lblSize?.text! = sizeDataModel.sizeName!
        SizeCollection.lblSize!.tag = indexPath.row
        
        
        print(SizeCollection.lblSize!.text!)
        
        
        
        
        
        return SizeCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SellerAddSizeCollectionCell
        
        cell.AddSizetoggleSelected()
        
        let getSize = arrAddsize[indexPath.row].sizeRef

      
       // selectedSize.updateValue(getSize!, forKey: "sizeRef")
       selectedSize.append(getSize!)
       
        print(selectedSize)

        let defaults = UserDefaults.standard
        defaults.setValue(selectedSize, forKey: "DefaultsSelectedSize")
        
        arrAddSizeSelected.append(indexPath.row)
        print(arrAddSizeSelected)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SellerAddSizeCollectionCell
        cell.AddSizetoggleSelected()
        
        if  arrAddSizeSelected.contains(indexPath.row) {
            let indexSelected = arrAddSizeSelected.firstIndex(of: indexPath.row)!
            arrAddSizeSelected.remove(at: indexSelected)
            
        }
        
        else
        {
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 42 , height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
    
    
    
}

