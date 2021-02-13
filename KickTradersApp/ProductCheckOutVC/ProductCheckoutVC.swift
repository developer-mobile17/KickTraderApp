//
//  ProductCheckoutVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit
import WebKit
class ProductCheckoutVC: UIViewController,WKNavigationDelegate,WKUIDelegate  {

    //MARK:- PayPal Setup




//**************************************************************//

    @IBOutlet var paypalWebView: WKWebView!

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


      //  paypalWebView = WKWebView()

//        paypalWebView = WKWebView(frame: CGRect( x: 0, y: 200, width: self.view.frame.width, height: self.view.frame.height - 20 ), configuration: WKWebViewConfiguration() )
        self.view.addSubview(paypalWebView)
        paypalWebView.navigationDelegate = self
        paypalWebView.uiDelegate = self

        
        lblShoeBGColor.layer.cornerRadius = 8
        lblShoeBGColor.clipsToBounds = true
        lblShoeBGColor.layer.borderWidth = 1



        self.getProductDetail()
        strCartRef = DefaultsCheckOut.value(forKey:"CheckoutCartRef") as! String
        self.WebviewCalling()

    }



    func WebviewCalling() {

        let web_url =  URL(string:"\(payPalWebViewURL)\(strCartRef)")!
        let web_request = URLRequest(url: web_url)
        paypalWebView.load(web_request)
    }


    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        ProgressHUD.show(interaction: false)
        print(#function)
    }


    func webView(_ webView: WKWebView, didFinish  navigation: WKNavigation!)
    {
        ProgressHUD.dismiss()
        let uRL = webView.url?.absoluteString
        print("---Hitted URL--->\(uRL!)") // here you are getting URL

        if (uRL?.contains("payid") == true){
            //TODO:- Go to success Screen


            PayPalSuccessID = getQueryStringParameter(url: uRL!, param: "payid")
            self.callingOrderPlacedAPI()

        }
        else {


        }

    }


    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }



    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionProceedToPayment(_ sender: Any) {



        //TODO:- Go to success Screen
//        let orderPlaced = self.storyboard?.instantiateViewController(identifier: "OrderPlacedSuccessfullyVC") as! OrderPlacedSuccessfullyVC
//        self.navigationController?.pushViewController(orderPlaced, animated: true)




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
    func callingOrderPlacedAPI() {

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

