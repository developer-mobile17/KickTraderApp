//
//  SearchTopBrandCell.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SearchTopBrandCell: UITableViewCell {
    
    @IBOutlet var ShowBrandCollection: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ShowBrandCollection.allowsMultipleSelection = true;
    }
    

    func reloadBrandCollectionView() -> Void {
        self.ShowBrandCollection.reloadData()
    }
    
    
}


//TODO:- Collection View DataSource & Delegate
extension SearchTopBrandCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrbrands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellBrand = ShowBrandCollection.dequeueReusableCell(withReuseIdentifier: "BrandCollectionCell", for: indexPath) as! BrandCollectionCell
        
        let brandDataModel = arrbrands[indexPath.row]
        cellBrand.lblBrandName.text = brandDataModel.brandName
        
        return cellBrand
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("The Selected Brand is: ",arrbrands[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75 , height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

