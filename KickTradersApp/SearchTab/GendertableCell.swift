//
//  GendertableCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class GendertableCell: UITableViewCell {
    @IBOutlet var ShowGenderCollection : UICollectionView!
    var arrGender = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func reloadGenderCollectionView()-> Void {
        arrGender = ["Male","Female","Both"]
        self.ShowGenderCollection.reloadData()
        
    }
}


extension GendertableCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrGender.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cellGender = ShowGenderCollection.dequeueReusableCell(withReuseIdentifier: "GenderCollectionCell", for: indexPath) as! GenderCollectionCell
        cellGender.lblGender.text = arrGender[indexPath.row]
        
         cellGender.lblGender.layer.cornerRadius = 7
         cellGender.lblGender.clipsToBounds = true
        
        
        return cellGender
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("You selected cell #\(indexPath.item)! \(arrGender[indexPath.row])")
        let cell = collectionView.cellForItem(at: indexPath) as? GenderCollectionCell
        cell?.isSelected = true
        cell?.toggleSelected()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as? GenderCollectionCell
        cell?.isSelected = false
        cell?.toggleSelected()
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80 , height: 40)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

