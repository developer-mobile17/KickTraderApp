//
//  SellerSignUpVerficationVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerSignUpVerficationVC: UIViewController {
    
    @IBOutlet var txfOtp: UITextField!
    var mobile:String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        mobile = defaults.string(forKey:"Defaultsmobile")
      
    }

}

//MARK:- UIButton Action
extension SellerSignUpVerficationVC {
    
    @IBAction func actoinBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionContinue(_ sender: Any)
    {
        self.VerficationAPICalling()
    }
    
    @IBAction func actionResendCode(_ sender: Any)
    {
        
        self.GetOtpAPICalling()
    }
}


//MARK:- Verification WebAPI Calling
extension SellerSignUpVerficationVC {
    func VerficationAPICalling() {
        
        guard let otp = txfOtp.text else {return}
        
        guard let mobilePass =  mobile else {return}
        
        let verfictionParam = SellerSignUpVerfication(Code: otp, mobile:mobilePass)
        print("verification Param are: ",verfictionParam)
        
        APIManger.shareInstance.callingSellerSignUpVerficationAPI(sellerSignUpVerfication: verfictionParam) {(result) in
            
            switch result {
            case.success(let json):
                print(json!)
                
                let status = (json as! SellerSignUpVerficationResponse).status
                if status == "success" {
                    print("Success")
                    
                    //TODO:- Go to Login after Verification
                    
                    self.GoToLoginClass()
 
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


//MARK:- Get OTP  WebAPI Calling
extension SellerSignUpVerficationVC {
    func GetOtpAPICalling() {
        
        
        let getOtpParam = sellerGetOtp(mobile: mobile!)
        APIManger.shareInstance.callingSellerGetOtpAPI(getOtp: getOtpParam) {(result) in
            
            switch result {
            case.success(let json):
                print(json!)
                
                let status = (json as! sellerGetOtpResponse).status
                if status == "success" {
                    print("msg:",(json as! sellerGetOtpResponse).msg!)
                    
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


extension SellerSignUpVerficationVC {
    func GotORestPassUI(){
        
        let buyerStoryBoard = UIStoryboard(name: "Main", bundle:nil)
        let  buyerStoryVC = buyerStoryBoard.instantiateViewController(identifier: "ResetPasswordVC")
        self.navigationController?.pushViewController(buyerStoryVC, animated: true)
        
    }
}



extension SellerSignUpVerficationVC {
    func GoToLoginClass(){
        
        let buyerStoryBoard = UIStoryboard(name: "Main", bundle:nil)
        let  buyerStoryVC = buyerStoryBoard.instantiateViewController(identifier: "LoginVC")
        self.navigationController?.pushViewController(buyerStoryVC, animated: true)
        
    }
}




