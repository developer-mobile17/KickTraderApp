//
//  EnterOTPVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class EnterOTPVC: UIViewController {
    var passOTP : String!
    var passMobileNo : String!
    @IBOutlet var txfOtp : UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

    }
    

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        
        if txfOtp.text == "" {
            showAlert(alertMessage: "Enter Otp")
        }
        else {
            
            DispatchQueue.main.async {
                self.CallingEnterOtpAPI()
            }
        }
       
    }
}

extension EnterOTPVC {
    func CallingEnterOtpAPI(){
        
        guard let otp = txfOtp.text else {return}
        
        guard let mobile =  passMobileNo else {return}
        
        let enterOtpParam = EnterOtpModel(Code: otp, mobile:mobile)
        print("verification Param are: ",enterOtpParam)
        
        BuyerAPIManager.shareInstance.callingEnterOtpAPI(EnterOtpParam: enterOtpParam) {(result) in
            
            switch result {
            case.success(let json):
                print(json!)
                
                let status = (json as! EnterOtpModelResponse).status
                if status == "success" {
                    print("Success")
                    
                    //TODO:- Go to Reset Password View
                    
                    self.goToResetView()
 
                }
                else{
                    print("Error")
                }
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
        
    }
}
extension EnterOTPVC {
    func goToResetView(){
        let vwRestPassword = self.storyboard?.instantiateViewController(identifier: "ResetPasswordVC") as! ResetPasswordVC
        vwRestPassword.strOtp = txfOtp.text
        vwRestPassword.strMobile = passMobileNo
        self.navigationController?.pushViewController(vwRestPassword, animated: true)
    }
}


