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




    override func viewDidLoad() {
        super.viewDidLoad()

        lblShoeBGColor.layer.cornerRadius = 8
        lblShoeBGColor.clipsToBounds = true
        lblShoeBGColor.layer.borderWidth = 1

        
        let img = (DefaultsCheckOut.value(forKey: "CheckoutProductImg") as! String)
        print(img)
        let imgProfileURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(img)")
        self.imgShoe.kf.setImage(with:imgProfileURL!)




       // lblShoeBrand.text = (DefaultsCheckOut.value(forKey: "CheckoutProductImg") as! String)
        lblShoeBrand.text = (DefaultsCheckOut.value(forKey: "CheckoutBrandName") as! String)
        lblShoeName.text = (DefaultsCheckOut.value(forKey: "CheckoutProductName") as! String)
        lblShoeSize.text = (DefaultsCheckOut.value(forKey: "CheckoutSizeName") as! String)
        lblShoeBGColor.backgroundColor = UIColor(hexFromString:(DefaultsCheckOut.value(forKey: "CheckoutColorRef") as! String))
        lblActualPrice.text = (DefaultsCheckOut.value(forKey: "CheckoutProductPrice") as! String)
        lblBidPrice.text = "\("$") \((DefaultsCheckOut.value(forKey: "CheckoutBidPrice") as! String))"
        lblShippingCharges.text = "\("$") \(7)"
        lblTotalCharges.text = "No Data"


        print(UserDefaults.standard.value(forKey:"CheckoutBidPrice")!)
    }





    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }



}
