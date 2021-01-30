//
//  ContactUsVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController,UITextViewDelegate {

    @IBOutlet var txvContactUs: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txvContactUs.delegate = self
        txvContactUs.text = "Enter your message."
        txvContactUs.textColor = UIColor.lightGray


    }

    @IBAction func actionSendMessage(_ sender: Any) {

        if txvContactUs.text == "" {
            showAlert(alertMessage: "Enter your message.")

        }
        if txvContactUs.text == "Enter your message." {
            showAlert(alertMessage: "Enter your message.")
        }
        else {
            self.callingContactUs_API()
        }

    }



    func textViewDidBeginEditing(_ textView: UITextView) {

            txvContactUs.textColor = UIColor.lightGray
            txvContactUs.text = ""
            txvContactUs.textColor = UIColor.black
        }



    func textViewDidEndEditing(_ textView: UITextView) {

        if txvContactUs.text == "" {

            txvContactUs.text = "Enter your message."
            txvContactUs.textColor = UIColor.lightGray
        }

    }
}

extension ContactUsVC {
    func callingContactUs_API() {

        ProgressHUD.show("Please wait.",  interaction: false)
        let contactUs_param = ContactUs_Request(userRef: UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String, message: txvContactUs.text)

        BuyerAPIManager.shareInstance.callingContactUs_API(contactUsParam: contactUs_param) {(result) in

            switch result {
            case.success(let json):
                print(json!)
                let msg = (json as! ContactUs_Response).msg!
                print(msg)
                ProgressHUD.dismiss()
                self.txvContactUs.text = ""
                AppSnackBar.make(in: self.view, message: msg, duration: .lengthShort).show()

                

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }
}
