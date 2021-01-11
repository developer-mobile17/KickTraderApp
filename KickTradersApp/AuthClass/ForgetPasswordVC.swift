//
//  ForgetPasswordVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {
    @IBOutlet var txfEmail : UITextField!
    var oTP : Int!
    var mobilePass: String!
    var userClickForgetPassword: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionForgetPasswordClicked(_ sender: Any) {
        
        if txfEmail.text == "" {
            showAlert(alertMessage: "Please enter your valid email id")
        }
        
        else {
        
        ProgressHUD.show("Fetching Email.", interaction: true)
        DispatchQueue.main.async {
            self.CallingForgetPasswordAPI()
        }
    }
    }
    
}


extension ForgetPasswordVC {
    func CallingForgetPasswordAPI(){
        
        ProgressHUD.dismiss()
        
        guard let mobile = txfEmail.text else {  return }
        mobilePass = txfEmail.text!
        
        let getOtpParam = sellerGetOtp(mobile: mobile)
        APIManger.shareInstance.callingSellerGetOtpAPI(getOtp: getOtpParam) { [self](result) in
            
            switch result {
            case.success(let json):
                print(json!)
                
                let status = (json as! sellerGetOtpResponse).status
                if status == "success" {
                    print("msg:",(json as! sellerGetOtpResponse).msg!)
                    self.oTP = (json as! sellerGetOtpResponse).otp
                    self.GoToEnterOTPView()
                }
                else{
                    print("Error")
                    showAlert(alertMessage:(json as! sellerGetOtpResponse).msg!)
                }
                
                
            case.failure(let err):
                print(err.localizedDescription)
                showAlert(alertMessage:err.localizedDescription)
            }
            
        }
        
        
    }
}


extension ForgetPasswordVC {
    func GoToEnterOTPView() {
        
       let  vwEnterOTP = self.storyboard?.instantiateViewController(identifier: "EnterOTPVC") as! EnterOTPVC
        vwEnterOTP.passOTP = self.oTP
        vwEnterOTP.passMobileNo = mobilePass
        self.navigationController?.pushViewController(vwEnterOTP, animated: true)
    
    }
}
