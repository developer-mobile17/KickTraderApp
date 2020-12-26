//
//  MoreVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
struct MoreOptionData {
    let moreMenu : String
}

class MoreVC: UIViewController {
    @IBOutlet var objCollection: UICollectionView!
    var arrMenus = [MoreOptionData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrMenus = [MoreOptionData(moreMenu: "Profile"),MoreOptionData(moreMenu: "Transactions"),MoreOptionData(moreMenu: "Favourites"),MoreOptionData(moreMenu: "Track Delivery"),MoreOptionData(moreMenu: "Unboxing Videos"),MoreOptionData(moreMenu: "Settings"),MoreOptionData(moreMenu: "Notifications"),MoreOptionData(moreMenu: "About"),MoreOptionData(moreMenu: "Contact"),]
        
    }
    
    @IBAction func actionBuyerLogout(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension MoreVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 2
        return arrMenus.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreVCCell", for: indexPath) as! MoreVCCell
    
       
        let MenusModel = arrMenus[indexPath.row]
        cell.lblMenuTitle.text = MenusModel.moreMenu
      
        
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  print("You selected cell #\(indexPath.item)!")
        
        let strData = arrMenus[indexPath.item].moreMenu
        print(strData)
        
        if (strData ==  "Profile"){
            guard let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileVC else{
                
                return
            }
            
            present(vc, animated: true)
        }
            
            
        else if (strData ==  "Notifications"){
            guard let vc = storyboard?.instantiateViewController(identifier: "NotificationVC") as? NotificationVC else{
                
                return
            }
            present(vc, animated: true)
        }
            
            
        else if (strData ==  "Unboxing Videos"){
            guard let vc = storyboard?.instantiateViewController(identifier: "UnBoxingVideoVC") as? UnBoxingVideoVC else{
                
                return
            }
            present(vc, animated: true)
        }
            
            
        else if (strData ==  "Favourites"){
            guard let vc = storyboard?.instantiateViewController(identifier: "FavouriteProductVc") as? FavouriteProductVc else{
                
                return
            }
            present(vc, animated: true)
        }
        
        
            
            
        else {
             let vcTrans = storyboard?.instantiateViewController(identifier: "TransactionVC") as! TransactionVC
            self.navigationController?.pushViewController(vcTrans, animated: true)
            
            
        }
        
        
    }

    
}
extension MoreVC: UICollectionViewDelegateFlowLayout {


func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    
    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    
    let numberofItem: CGFloat = 3
    
    let collectionViewWidth = self.objCollection.bounds.width
    
    let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
    
    let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
    
    let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
    
   // print(width)
    
    return CGSize(width: width, height: width)
}
}
