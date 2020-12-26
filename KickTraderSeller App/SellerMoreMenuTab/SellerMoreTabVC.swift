//
//  SellerMoreTabVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 05/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


struct SellerMoreMenu {
    
    let TitleMenu: String!
    let ImgTitle: String!
}

class SellerMoreTabVC: UIViewController {
    
    @IBOutlet var objCollection: UICollectionView!
    
    var arrMoreMenu = [SellerMoreMenu]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        arrMoreMenu = [SellerMoreMenu(TitleMenu: "Profile", ImgTitle: ""),SellerMoreMenu(TitleMenu: "Earnings", ImgTitle: ""),SellerMoreMenu(TitleMenu: "Settings", ImgTitle: ""),SellerMoreMenu(TitleMenu: "Notifications", ImgTitle: ""),SellerMoreMenu(TitleMenu: "About", ImgTitle: ""),SellerMoreMenu(TitleMenu: "Contact", ImgTitle:"")]
        
        
    }
    @IBAction func actionSellerLogout(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


//MARK:- Datasource Cell
extension SellerMoreTabVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMoreMenu.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SellerMoreCollectionCell", for: indexPath) as! SellerMoreCollectionCell
        
        let SellerMenuModel = arrMoreMenu[indexPath.row]
        cell.lblMenuTitle.text = SellerMenuModel.TitleMenu
        // cell.imgMenu.text = SellerMenuModel.ImgTitle
        
        return cell
    }
    
    
    
    //MARK:- Delegate Cell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let strMenu = arrMoreMenu[indexPath.row].TitleMenu
        
               if (strMenu ==  "Profile"){
                   guard let vcProfile = storyboard?.instantiateViewController(identifier: "SellerProfileVC") as? SellerProfileVC else{
       
                       return
                   }
                
                let navController = UINavigationController(rootViewController: vcProfile)
                   present(navController, animated: true)
               }
        
        
        else if(strMenu ==  "Earnings"){
                    guard let vcEarning = storyboard?.instantiateViewController(identifier: "SellerEarningVC") as? SellerEarningVC else{
        
                        return
                    }
            self.navigationController?.pushViewController(vcEarning, animated: true)
                }
        
//
//        guard let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as? selle else{
//
//                       return
//                   }
//                   present(vc, animated: true)
//               }
//
        
        //  print("You selected cell #\(indexPath.item)!")
//
//        let strData = arrMoreMenu[indexPath.item].
//        print(strData)
//
//        if (strData ==  "Profile"){
//            guard let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileVC else{
//
//                return
//            }
//            present(vc, animated: true)
//        }
//
//
//
//    }
}

}


//MARK:- FlowLayout Cell
extension SellerMoreTabVC : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             return CGSize(width: 107 , height: 126)
         }

         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
         }


}

