//
//  CartVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


class CartVC:UIViewController{

    
    @IBOutlet var objtable : UITableView!
    @IBOutlet var imgEmptyCart: UIImageView!
    var arrCartData = [CartItem]()
     var selecteCartRef : String = ""
     var selectedProductRef : String = ""
     var strBidPrice: String = " "
     var strstatus: String = " "
     var strBtnTitleChecked: String = ""
     var strPlaceABidPrice: String = ""
     var strcartRef: String = ""
     var defaults = UserDefaults.standard
    var strActionFav: String?



    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.imgEmptyCart.isHidden = true
        self.callingCartAPI()
    }
    

}
//MARK:- getCartItem API
extension CartVC {
    func callingCartAPI(){
        
        ProgressHUD.show("Loading...", interaction: false)
        
        
        
        let productDetailParam = getCartItemModel(buyerRef:defaults.value(forKey: "DefaultsbuyerRef") as! String)
        BuyerAPIManager.shareInstance.callinggetCartItemAPI(getCartItemparam: productDetailParam) {(result) in
            
            switch result{
            case.success(let json):
                print(json!)
                
                ProgressHUD.dismiss()
                self.arrCartData = (json as! getCartModelResponse).cartItem!
                let msg = (json as! getCartModelResponse).msg!
                if msg == "Cart empty."{
                    self.imgEmptyCart.isHidden = false
                }
                
               
                self.objtable.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
    
        }
  
    }
}


extension CartVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrCartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as!cartCell
        
        let MyCartData = self.arrCartData[indexPath.row]
        
       
        let imgURL = URL(string:"\(PRODUCT_COVER_IMAGE)\(MyCartData.productCoverImage!)")
        cell.imgShoes.kf.setImage(with: imgURL)
        cell.lblShoeName.text = MyCartData.productName?.capitalized
        cell.lblSize.text = MyCartData.sizeName
        cell.lblColor.backgroundColor = UIColor(hexFromString:MyCartData.colorCode!)
        cell.lblProductPrice.text = "\("Product Price:$")\(MyCartData.productPrice!)"
        strBidPrice = MyCartData.bidPrice!


        //TODO:- check favourite ID and show the icon accordingly

        if let getFavID =  MyCartData.favoriteId {
           print(getFavID)
            cell.btnAddToFavourite.isSelected = true

        }
         else
        {
            cell.btnAddToFavourite.isSelected = false
        }

        if strBidPrice == "" {
            cell.lblBidPrice.isHidden = true
        }
        else {
            cell.lblBidPrice.text = "\("Bid Price:$")\(strBidPrice)"
        }
        
        
        if MyCartData.status == "pending"
        {
         cell.lblStatus.isHidden = false
         cell.lblStatus.textColor = UIColor.systemYellow
         cell.btnBuyOrPlaceBid.isHidden = true
        }
        if MyCartData.status == "accepted"
        {
            cell.lblStatus.textColor = UIColor.systemGreen
            cell.btnBuyOrPlaceBid.isHidden = false
            cell.btnBuyOrPlaceBid.setTitle("Buy Now", for: .normal)
        }
        if MyCartData.status == "noStatus"
        {
            cell.lblStatus.isHidden = true
            cell.btnBuyOrPlaceBid.isHidden = false
            cell.btnBuyOrPlaceBid.backgroundColor =  UIColor.systemRed
            cell.btnBuyOrPlaceBid.setTitle("Place Bid", for: .normal)
        }
        
        
        
        if MyCartData.status == "rejected"
        {
            cell.lblStatus.isHidden = true
            cell.btnBuyOrPlaceBid.isHidden = false
            cell.btnBuyOrPlaceBid.backgroundColor =  UIColor.systemRed
            cell.btnBuyOrPlaceBid.setTitle("Place Bid", for: .normal)
        }
        

        cell.lblStatus.text = MyCartData.status?.capitalized
        
        

        //TODO:- UIButton Action Favourite
         cell.btnAddToFavourite.tag = indexPath.row
         cell.btnAddToFavourite .addTarget(self, action: #selector(bntAddToFavouriteClicked), for:.touchUpInside)
        
        
       //TODO:- UIButton Action Delete
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete .addTarget(self, action: #selector(bntRemoveCartItemClicked), for:.touchUpInside)
        
        //TODO:- UIButton Action Buy Now Or Place Bid
        
        cell.btnBuyOrPlaceBid.tag = indexPath.row
        cell.btnBuyOrPlaceBid.addTarget(self, action: #selector(btnBuyNowOrPlaceBid), for: .touchUpInside)
        
        
        
        
        return cell
    }
    
}



//MARK:- Button remove Cart Item Clicked
extension CartVC{
    @objc func btnBuyNowOrPlaceBid(sender: UIButton){
        
        strBtnTitleChecked = self.arrCartData[sender.tag].status!
        
        if strBtnTitleChecked == "noStatus" {
            print("Place Bid Did Tap!")
            strcartRef = self.arrCartData[sender.tag].cartRef!
            self.PlaceBidalAlertOfCart()
        }


        //TODO:- Buy Now Product
        if strBtnTitleChecked == "accepted" {
            print("Buy Now Did Tap!")

            
            defaults.setValue(self.arrCartData[sender.tag].productCoverImage!, forKey: "CheckoutProductImg")
            defaults.setValue(self.arrCartData[sender.tag].brandName!, forKey: "CheckoutBrandName")
            defaults.setValue(self.arrCartData[sender.tag].productName!, forKey: "CheckoutProductName")
            defaults.setValue(self.arrCartData[sender.tag].sizeName!, forKey: "CheckoutSizeName")
            defaults.setValue(self.arrCartData[sender.tag].colorRef!, forKey: "CheckoutColorRef")
            defaults.setValue(self.arrCartData[sender.tag].productPrice!, forKey: "CheckoutProductPrice")
            defaults.setValue(self.arrCartData[sender.tag].bidPrice!, forKey: "CheckoutBidPrice")
            defaults.setValue(self.arrCartData[sender.tag].cartRef!, forKey: "CheckoutCartRef")



            self.GoToChooseAddress()
        }
        
        
        if strBtnTitleChecked == "rejected" {
            print("Place Bid Did Tap!")
            strcartRef = self.arrCartData[sender.tag].cartRef!
            self.PlaceBidalAlertOfCart()
        }
        
    
    }
}

extension CartVC {
    func GoToChooseAddress(){
        
        let vcAddressSelect = self.storyboard?.instantiateViewController(identifier: "AddressListVC") as! AddressListVC
        vcAddressSelect.strPassSelectedCartRef = strcartRef
        self.navigationController?.pushViewController(vcAddressSelect, animated: true)
        
    }
}



extension CartVC {
    func PlaceBidalAlertOfCart() {
        //Step : 1
        let alert = UIAlertController(title: "KickTrader App", message: "Enter Place Bid Amount", preferredStyle: UIAlertController.Style.alert )
        //Step : 2
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textFieldBid = alert.textFields![0] as UITextField
            if textFieldBid.text != "" {
                //Read TextFields text data
                print(textFieldBid.text!)
                self.strPlaceABidPrice = textFieldBid.text!
                print("TF 1 : \(textFieldBid.text!)")
               
                
            } else {
                print("TF 1 is Empty...")
            }
            
            self.callingPlaceBidCartAPI()
           
        }

        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
        textField.textColor = .black
        }
       
        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)

    }
}



//TODO:- Place A Bid API
extension CartVC {
    func callingPlaceBidCartAPI() {
        
        ProgressHUD.show("Please wait.",  interaction: false)
        let placeBidCartParma = placeABidInToCartModel(cartRef: strcartRef, bidPrice: strPlaceABidPrice)
       
        BuyerAPIManager.shareInstance.callingplaceBidInToCartAPI(placeABidInToCartParam: placeBidCartParma) {(result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                let msg = (json as! placeABidInToCartModelResponse).msg
                print(msg)
                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}




//MARK:- Button remove Cart Item Clicked
extension CartVC{
    @objc func bntRemoveCartItemClicked(sender: UIButton){
        
        selecteCartRef = self.arrCartData[sender.tag].cartRef!
        print(selecteCartRef)
        self.callingRemoveCartAPI()
    }
}



//MARK:- Button add to favourite
extension CartVC{
    @objc func bntAddToFavouriteClicked(sender: UIButton){

        selecteCartRef = self.arrCartData[sender.tag].productRef!
        print(selecteCartRef)


        sender.isSelected.toggle()

        if sender.isSelected {
            print("selected")

            strActionFav = "1"
            self.addProductToFavourite()
        }
        else {
            print("Not selected")
            strActionFav = "0"
          self.addProductToFavourite()

        }




        //self.callingRemoveCartAPI()
    }
}




//MARK:- removeCartItem API
extension CartVC {
    func callingRemoveCartAPI(){
        
        let removeCartParm = removeCartItemModel(buyerRef:defaults.value(forKey: "DefaultsbuyerRef") as! String, cartRef: selecteCartRef)
        BuyerAPIManager.shareInstance.callingRemoveCartItemAPI(removeCartItemparam:removeCartParm) {(result) in
            
            switch result{
            case.success(let json):
                print(json!)
                let status = (json as! removeCartItemResponse).status
                print(status)
                
                self.callingCartAPI()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
    
        }
  
    }
}


extension CartVC {
    func addProductToFavourite(){

        ProgressHUD.show(interaction: false)
        let addFavouriteParma = addFavoriteModel(buyerRef:defaults.value(forKey: "DefaultsbuyerRef") as! String , productRef: selecteCartRef ,action:strActionFav!)
       // print(addFavouriteParma)
        BuyerAPIManager.shareInstance.addFavoriteAPI(addFavoriteParam: addFavouriteParma) {(result) in

            switch result{
            case.success(let json):
                ProgressHUD.dismiss()
                print((json as! addFavoriteModelResponse).msg)
                AppSnackBar.make(in: self.view, message: ((json as! addFavoriteModelResponse).msg), duration: .lengthShort).show()

            case.failure(let err):
                print(err.localizedDescription)
            }

        }

    }
}


