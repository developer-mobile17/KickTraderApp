//
//  ProductCheckoutVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class ProductCheckoutVC: UIViewController, PayPalPaymentDelegate {

    //MARK:- PayPal Setup


    var environment:String = PayPalEnvironmentSandbox {
    willSet(newEnvironment) {
    if (newEnvironment != environment) {
    PayPalMobile.preconnect(withEnvironment: newEnvironment)
                }
            }
        }

    var payPalConfig = PayPalConfiguration()

//**************************************************************//


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
    var PayPalSuccessID:String!
    var bidPriceToNumeric: Int!


    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        lblShoeBGColor.layer.cornerRadius = 8
        lblShoeBGColor.clipsToBounds = true
        lblShoeBGColor.layer.borderWidth = 1


        //TODO:- Paypal configure here..
        payPalConfig.payPalShippingAddressOption = .both

        self.getProductDetail()

    }

   //TODO:- paypal preconnect setup here
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            PayPalMobile.preconnect(withEnvironment: environment)
        }



    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionProceedToPayment(_ sender: Any) {



        //TODO:- Go to success Screen
//        let orderPlaced = self.storyboard?.instantiateViewController(identifier: "OrderPlacedSuccessfullyVC") as! OrderPlacedSuccessfullyVC
//        self.navigationController?.pushViewController(orderPlaced, animated: true)



        let totalAmount = totalChargesGenric(bidPrice: bidPriceToNumeric!, shippingCharges: 7)
        let TotalAmtDecimal =  NSDecimalNumber(value: totalAmount)

        //TODO:- paypal payment gateway calling here on button click
        let payment = PayPalPayment(amount: TotalAmtDecimal, currencyCode: "USD", shortDescription: (DefaultsCheckOut.value(forKey: "CheckoutProductName") as! String), intent: .sale)


        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {

            print("Payment not processalbe: \(payment)")
            showAlert(alertMessage:"Payment not processalbe")
        }

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

        bidPriceToNumeric = Int(DefaultsCheckOut.value(forKey: "CheckoutBidPrice") as! String)
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
        print("PayPal Success ID",PayPalSuccessID!)

        // CheckoutCartRef

        strCartRef = DefaultsCheckOut.value(forKey:"CheckoutCartRef") as! String
        strBuyRef = DefaultsCheckOut.value(forKey:"DefaultsbuyerRef") as! String
       // strAddressCartRef = DefaultsCheckOut.value(forKey:"DefaultsbuyerRef") as! String

        let buyProductParam = buyProductModel(cartRef: strCartRef, buyerRef: strBuyRef, addressRef: strAddressCartRef,payId: PayPalSuccessID)
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

//MARK:- PayPal Payment Gateway integration.
extension ProductCheckoutVC {
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }

    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { [self] () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")


            let paymentResultDic = completedPayment.confirmation as NSDictionary


            let dicResponse: AnyObject? = paymentResultDic.object(forKey: "response") as AnyObject
            self.PayPalSuccessID = dicResponse?.object(forKey: "id") as? String
            print(self.PayPalSuccessID!)
            //TODO:- Sending Paypal id to server for reference
            self.callingBuyOrderAPI()

            })
    }

}
