//
//  TransactionVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class TransactionVC: UIViewController {

    @IBOutlet var objTbl:UITableView?
    @IBOutlet var btnBack:UIButton!
    
    var arrTransctionData = [BuyerOrders]()
    var arrPasstransForRating = [NSArray]()
    var defaultTrans = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        self.callinggetBuyerOrdersAPI()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}


//TODO:- get Buyer Orders  API
extension TransactionVC {
    func callinggetBuyerOrdersAPI() {
        
        ProgressHUD.show("Please wait.",  interaction: false)
        
        let getBuyerOrdersParam = getBuyerOrders(buyerRef: defaultTrans.value(forKey: "DefaultsbuyerRef") as! String)
        
        BuyerAPIManager.shareInstance.getBuyerOrdersAPI(getBuyerOrdersParam: getBuyerOrdersParam) { [self] (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                
                self.arrTransctionData = (json as! getBuyerOrdersResponse).buyerOrders!
                
                self.objTbl?.reloadData()
                let msg = (json as! getBuyerOrdersResponse).msg!
                print(msg)
                
            //self.callingFetchingShippingAddressAPI()

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }

}


extension TransactionVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrTransctionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as!TransactionCell
        
        let MyTransctionData = arrTransctionData[indexPath.row]
        
        if let imgURL = URL(string:"\(PRODUCT_COVER_IMAGE)\(MyTransctionData.productCoverImage ?? "")"){
            cell.imgShoes.kf.setImage(with: imgURL)
        }

        cell.lblShoeBrandName.text = MyTransctionData.brandName
        cell.lblShoeName.text = MyTransctionData.productName
        cell.lblSize.text = MyTransctionData.sizeName

        if let colorCode  = MyTransctionData.colorCode {
            cell.lblColor.backgroundColor = UIColor(hexFromString:colorCode)

        }
       // cell.lblColor.backgroundColor = UIColor(hexFromString:MyTransctionData.colorCode!)
        
        cell.lblPrice.text =  "\("$")\(String(describing: MyTransctionData.bidPrice!))"
        cell.lblDate.text = MyTransctionData.orderedDate


        //TODO:- UIButton Action Add Rating
        
        cell.btnAddRating.tag = indexPath.row
        cell.btnAddRating.addTarget(self, action: #selector(btnAddRating), for: .touchUpInside)
        
        
        
        let orderStatus = MyTransctionData.orderStatus
        let capitalizedLable = orderStatus?.capitalized
        cell.lblStatus.text = capitalizedLable
        if orderStatus == "pending"{

            cell.lblStatus.textColor = UIColor.systemYellow
        }
        else if orderStatus == "cancelled" {

            cell.lblStatus.textColor = UIColor.systemRed
        }
        
        else {
            cell.lblStatus.textColor = UIColor.systemGreen
        }
        
        
        
        
        
        return cell
    }




    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetails =  self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as! ProductDetailVC

        let productRef = arrTransctionData[indexPath.row].productRef

        let Defaults = UserDefaults.standard
        Defaults.set(productRef, forKey: "DefaultsproductRef")
        self.navigationController?.pushViewController(productDetails, animated: true)
    }
    
    
}


//MARK:- Button Add Rating Clicked
extension TransactionVC{
    @objc func btnAddRating(sender: UIButton){
        
        let vcOrderDetails = self.storyboard?.instantiateViewController(identifier: "TransctionOrderDetailsVC") as! TransctionOrderDetailsVC
        //TODO:- Order Number Pass for tracking Order UI
        defaultTrans.setValue(self.arrTransctionData[sender.tag].orderNumber,forKey:"DefaultorderNumber")
        defaultTrans.setValue(self.arrTransctionData[sender.tag].sellerRef,forKey:"DefaultsellerRef")
        
        //TODO:- Product Info
        let selectedProductRef = self.arrTransctionData[sender.tag].productRef
        let productName = self.arrTransctionData[sender.tag].productName
        let brandName = self.arrTransctionData[sender.tag].brandName
        let productCoverImage = self.arrTransctionData[sender.tag].productCoverImage
        let colorCode = self.arrTransctionData[sender.tag].colorCode
        let bidPrice = self.arrTransctionData[sender.tag].bidPrice
        let productSize = self.arrTransctionData[sender.tag].sizeName
        let orderStatus = self.arrTransctionData[sender.tag].orderStatus
        let orderNumber = self.arrTransctionData[sender.tag].orderNumber
        
        defaultTrans.setValue(selectedProductRef, forKey:"DefaultsProductRef")
        defaultTrans.setValue(productName, forKey:"DefaultsproductName")
        defaultTrans.setValue(brandName, forKey:"DefaultsbrandName")
        defaultTrans.setValue(productCoverImage, forKey:"DefaultsproductCoverImage")
        defaultTrans.setValue(colorCode, forKey:"DefaultscolorCode")
        defaultTrans.setValue(bidPrice, forKey:"DefaultsbidPrice")
        defaultTrans.setValue(productSize, forKey:"DefaultsproductSize")
        defaultTrans.setValue(orderStatus, forKey:"DefaultsorderStatus")
        defaultTrans.setValue(orderNumber, forKey:"DefaultsorderNumber")
        
        
        

        vcOrderDetails.strProductRef = selectedProductRef
        vcOrderDetails.strproductName = productName
        vcOrderDetails.strproductCoverImage = productCoverImage
        vcOrderDetails.strbrandName = brandName
        vcOrderDetails.strcolorCode = colorCode
        vcOrderDetails.strbidPrice = bidPrice
        vcOrderDetails.strSize = productSize
        vcOrderDetails.strOrderStatus = orderStatus
        vcOrderDetails.strOrderNumber = orderNumber
        //
        //

        
        //TODO:- Seller Info
        
        let selectedSellerRef = self.arrTransctionData[sender.tag].sellerInfo?.userRef
        let selectedSellerFull_Name = self.arrTransctionData[sender.tag].sellerInfo?.full_Name
        let selectedSellerProfile_Image = self.arrTransctionData[sender.tag].sellerInfo?.profile_Image
        let selectedSellershop_description = self.arrTransctionData[sender.tag].sellerInfo?.shop_description

        defaultTrans.setValue(selectedSellerRef, forKey:"DefaultsSellerRef")
        defaultTrans.setValue(selectedSellerFull_Name, forKey:"DefaultsSellerFull_Name")
        defaultTrans.setValue(selectedSellerProfile_Image, forKey:"DefaultsSellerProfile_Image")
        defaultTrans.setValue(selectedSellershop_description, forKey:"DefaultsSellershop_description")

        self.navigationController?.pushViewController(vcOrderDetails, animated: true)
        

    }
}

