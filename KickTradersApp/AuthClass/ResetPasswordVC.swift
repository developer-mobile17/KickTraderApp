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

      
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionContinue(_ sender: Any) {
        self.CallingResetPasswordAPI()
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
                }
                
                
            case.failure(let err):
                print(err.localizedDescription)
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
