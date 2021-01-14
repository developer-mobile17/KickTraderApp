//
//  ProductCheckoutVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class ProductCheckoutVC: UIViewController {

    @IBOutlet var imgShoe: UIImageView!
    @IBOutlet var lblShoeBrand: UILabel!
    @IBOutlet var lblShoeName: UILabel!
    @IBOutlet var lblShoeSize: UILabel!
    @IBOutlet var lblShoeBGColor: UILabel!



    @IBOutlet var lblActualPrice: UILabel!
    @IBOutlet var lblBidPrice: UILabel!
    @IBOutlet var lblShippingCharges: UILabel!
    @IBOutlet var lblTotalCharges: UILabel!



    var DefaultsCheckOut = UserDefaults.standard
    var strAddressCartRef : String = ""
    var strBuyRef: String = ""
    var strCartRef: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblShoeBGColor.layer.cornerRadius = 8
        lblShoeBGColor.clipsToBounds = true
        lblShoeBGColor.layer.borderWidth = 1

        self.getProductDetail()

    }


    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionProceedToPayment(_ sender: Any) {

        //TODO:- Go to success Screen
        let orderPlaced = self.storyboard?.instantiateViewController(identifier: "OrderPlacedSuccessfullyVC") as! OrderPlacedSuccessfullyVC
        self.navigationController?.pushViewController(orderPlaced, animated: true)

       // self.callingBuyOrderAPI()
    }
    
    func getProductDetail() {
        let img = (DefaultsCheckOut.value(forKey: "CheckoutProductImg") as! String)
        print(img)
        let imgProfileURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(img)")
        self.imgShoe.kf.setImage(with:imgProfileURL!)

        lblShoeBrand.text = (DefaultsCheckOut.value(forKey: "CheckoutBrandName") as! String)
        lblShoeName.text = (DefaultsCheckOut.value(forKey: "CheckoutProductName") as! String)
        lblShoeSize.text = (DefaultsCheckOut.value(forKey: "CheckoutSizeName") as! String)
        lblShoeBGColor.backgroundColor = UIColor(hexFromString:(DefaultsCheckOut.value(forKey: "CheckoutColorRef") as! String))
        lblActualPrice.text = "\("$") \((DefaultsCheckOut.value(forKey: "CheckoutProductPrice") as! String))"
        lblBidPrice.text = "\("$") \((DefaultsCheckOut.value(forKey: "CheckoutBidPrice") as! String))"
        lblShippingCharges.text = "\("$") \(7)"

        let bidPriceToNumeric = Int(DefaultsCheckOut.value(forKey: "CheckoutBidPrice") as! String)
        let TotalCharges = totalChargesGenric(bidPrice: bidPriceToNumeric!, shippingCharges: 7)

        lblTotalCharges.text = "\("$") \(String(TotalCharges))"

        print(UserDefaults.standard.value(forKey:"CheckoutBidPrice")!)
    }


}


func totalChargesGenric<T:Numeric>(bidPrice:T, shippingCharges:T) -> T {
    return bidPrice + shippingCharges
}



//TODO:- Order Place / Buy  API
extension ProductCheckoutVC {
    func callingBuyOrderAPI() {

        ProgressHUD.show("Please wait.",  interaction: false)

        // CheckoutCartRef

        strCartRef = DefaultsCheckOut.value(forKey:"CheckoutCartRef") as! String
        strBuyRef = DefaultsCheckOut.value(forKey:"DefaultsbuyerRef") as! String
       // strAddressCartRef = DefaultsCheckOut.value(forKey:"DefaultsbuyerRef") as! String

        let buyProductParam = buyProductModel(cartRef: strCartRef, buyerRef: strBuyRef, addressRef: strAddressCartRef)
        print("Buy Product Param: ",buyProductParam)

        BuyerAPIManager.shareInstance.callingBuyProductAPI(buyProductPara: buyProductParam) { (result) in


            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
               let msg = (json as! buyProductModelResponse).msg
                 print(msg)

                //TODO:- Go to success Screen
                let orderPlaced = self.storyboard?.instantiateViewController(identifier: "OrderPlacedSuccessfullyVC") as! OrderPlacedSuccessfullyVC
                self.navigationController?.pushViewController(orderPlaced, animated: true)

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }

}
