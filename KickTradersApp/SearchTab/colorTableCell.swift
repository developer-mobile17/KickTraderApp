//
//  colorTableCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class colorTableCell: UITableViewCell {
    @IBOutlet var ShowColorCollection: UICollectionView!
    
    
    
    var arrColorSelected = [Int]()
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ShowColorCollection.allowsMultipleSelection = true
    }
    
    func reloadColorCollectionView() -> Void {
        
        
        self.ShowColorCollection.reloadData()
    }
    
    
    
    
    
    
}

extension colorTableCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrcolor.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ShowColorCollection.dequeueReusableCell(withReuseIdentifier: "ColorCollectionCell", for: indexPath) as! ColorCollectionCell
        
        let SearchData = arrcolor[indexPath.row]
        
        cell.cellCheckMarkImage.isHidden = true
        
        
        
        if arrColorSelected.contains(indexPath.row) {
           // cell.backgroundColor = UIColor.red
            cell.cellCheckMarkImage.isHidden = false
        }
        else{
            //cell.backgroundColor = UIColor.clear
            cell.cellCheckMarkImage.isHidden = true
        }
        
        cell.lblcolorBG.backgroundColor = UIColor(hexFromString:SearchData.colorCode!)
        cell.lblcolorBG.layer.cornerRadius = 7
        cell.lblcolorBG.clipsToBounds = true
        cell.lblcolorBG.tag = indexPath.row
        
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCollectionCell
        
        cell.toggleSelected()
        
        let data = arrcolor[indexPath.row].colorRef
        print("The color is: ",data!)
        
        
        arrColorSelected.append(indexPath.row)
        
        print(arrColorSelected)
        
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCollectionCell
        cell.toggleSelected()
        
        if  arrColorSelected.contains(indexPath.row) {
            let indexSelected = arrColorSelected.firstIndex(of: indexPath.row)!
            arrColorSelected.remove(at: indexSelected)
            
        }
        else {
            
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:48, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
}

