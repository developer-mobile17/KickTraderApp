//
//  FavouriteProductVc.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class FavouriteProductVc: UIViewController {

     @IBOutlet var objTbl:UITableView?
      var arrFavoriteData = [FavoriteItems]()
      var defaultFav = UserDefaults.standard

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        DispatchQueue.main.async {
            ProgressHUD.show("Please wait.",  interaction: false)
            self.callingFavoriteItemsAPI()
        }
        
        
    }
    
}

//TODO:- get Buyer Orders  API
extension FavouriteProductVc {
    func callingFavoriteItemsAPI() {
        
       // let getFavouriteParam = getFavoriteByBuyerModel(buyerRef: "cJte0ux3iNeLq")
        
       let getFavouriteParam = getFavoriteByBuyerModel(buyerRef: defaultFav.value(forKey: "DefaultsbuyerRef") as! String)
        
        
        BuyerAPIManager.shareInstance.getFavoriteByBuyerAPI(getFavoriteByBuyerParam:getFavouriteParam) { (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                
                self.arrFavoriteData = (json as! getFavoriteByBuyerModelResponse).favoriteItems!
                self.objTbl?.reloadData()
                let msg = (json as! getFavoriteByBuyerModelResponse).msg!
                print(msg)
                
                //self.callingFetchingShippingAddressAPI()
    
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}


extension FavouriteProductVc : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrFavoriteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as!FavouriteCell
        
        let MyFavoriteData = arrFavoriteData[indexPath.row]
        
        let imgURL = URL(string:"\(PRODUCT_COVER_IMAGE)\(MyFavoriteData.productCoverImage!)")
        cell.imgShoes.kf.setImage(with: imgURL)
        
        cell.lblShoeName.text = MyFavoriteData.productName
       
        cell.lblPrice.text =  "\("Price: $")\(String(describing: MyFavoriteData.productPrice!))"
        cell.vwStarRating.rating = Double(Float(MyFavoriteData.averageRating!)!)
        
        return cell
    }
    
    
}
