//
//  DisputeViewVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class DisputeViewVC: UIViewController,UITextViewDelegate {

    @IBOutlet var txvAddDispute: UITextView!
    @IBOutlet var imgShoes: UIImageView!
    @IBOutlet var lblShoeBrandName: UILabel!
    @IBOutlet var lblShoeName: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblOrderNumber: UILabel!
    var strproductCoverImage : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showShoeDetails()

    }

    @IBAction func actionAddDispute(_ sender: Any) {
        DispatchQueue.main.async {
            self.callingDisputeAPI()
        }
    }

    func showShoeDetails() {
        strproductCoverImage = UserDefaults.standard.value(forKey: "DefaultsproductCoverImage") as? String
        // Show Product info
        let imgProduct =  URL(string:"\(PRODUCT_COVER_IMAGE)\(strproductCoverImage!)")
        self.imgShoes.kf.setImage(with:imgProduct!)
        lblOrderNumber.text = "\("Order Number: ")\(String(describing: UserDefaults.standard.value(forKey: "DefaultsorderNumber") as! String))"
        lblShoeBrandName.text =  UserDefaults.standard.value(forKey: "DefaultsbrandName") as? String
        lblShoeName.text =  (UserDefaults.standard.value(forKey: "DefaultsproductName") as! String)
        lblSize.text =  (UserDefaults.standard.value(forKey: "DefaultsproductSize") as! String)
        lblPrice.text = "\("Bid Price:$") \(UserDefaults.standard.value(forKey: "DefaultsbidPrice") as? String ?? "")"
        lblColor.backgroundColor = UIColor(hexFromString: (UserDefaults.standard.value(forKey: "DefaultscolorCode") as? String)!)
    }
}

extension DisputeViewVC {
    func callingDisputeAPI() {

        ProgressHUD.show("Please wait.",  interaction: false)

        let addDisputeParam = addDisputeRequest(disputeBy:UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String, disputeTo: UserDefaults.standard.value(forKey: "DefaultsellerRef") as! String, disputeOn: UserDefaults.standard.value(forKey: "DefaultorderNumber") as! String, disputeComment: txvAddDispute.text ?? "")

        BuyerAPIManager.shareInstance.callingAddDispute_API(addDisputeParam: addDisputeParam) {(result) in

            switch result {
            case.success(let json):
                print(json!)
                let msg = (json as! addDisputeResponse).msg!
                print(msg)
                ProgressHUD.dismiss()

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }
}
