//
//  ResetPasswordVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
// 9988141771

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet var txfPasword: UITextField!
    @IBOutlet var txfConfirmPass: UITextField!
    
    var strMobile : String!
    var strOtp : String!
    
    var defultsResetPass = UserDefaults.standard
    
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
        
        if txfPasword.text == "" {
            showAlert(alertMessage: "Enter new password")
        }
        else if txfConfirmPass.text == "" {
            showAlert(alertMessage: "Enter confirm password")
        }
        else if txfPasword.text != txfConfirmPass.text {
            showAlert(alertMessage: "Password and confirm password doesn't match.")
        }
        
        else {
            DispatchQueue.main.async {
                self.CallingResetPasswordAPI()
            }
        }
        
    }
    
}



extension ResetPasswordVC {
    func CallingResetPasswordAPI(){
        
        ProgressHUD.dismiss()
        
        guard let newPassword  = txfPasword.text else {  return }
        guard let mobile = strMobile else {return}
        guard let otp = strOtp else {return}
        
        let resetPasswordParam = resetPasswordModel(Mobile: mobile, OTP: otp, Password: newPassword)
        APIManger.shareInstance.callingResetAPI(resetPasswordParam: resetPasswordParam) { (result) in
            
            switch result {
            case.success(let json):
                print(json!)
                
                let status = (json as! resetPasswordModelResponse).status!
                if status == "success" {
                    self.goToLoginUI()
                }
                else{
                    print("Error")
                    self.showAlert(alertMessage:(json as! resetPasswordModelResponse).msg!)
                }
                
                
            case.failure(let err):
                print(err.localizedDescription)
                self.showAlert(alertMessage:err.localizedDescription)
            }
            
        }
        
        
    }
}




//MARK:- Custom Method
extension ResetPasswordVC {
    
    func goToLoginUI(){
        let vwLogin = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vwLogin, animated: true)
    }
}
