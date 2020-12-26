//
//  SignupVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet var txfShop: UITextField!
    @IBOutlet var txfEmail: UITextField!
    @IBOutlet var txfPhoneNumber: UITextField!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var txfPassword: UITextField!
    @IBOutlet var txfConfirmPass: UITextField!
    @IBOutlet var btnGender: UIButton!
    
    
    var deviceToken: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionGenderSelect(_ sender: Any) {
    }
    
    
    
    
}

//MARK:- UIButton Action
extension SignupVC {
    
    @IBAction func actionContinue(_ sender: Any) {
        self.signUpAPICalling()
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func actionBack(_ sender: Any)
    {
    self.navigationController?.popViewController(animated: true)
    }
}
    
    
    


//MARK:- API Calling...
extension SignupVC {
    func signUpAPICalling (){
        guard let name = txfShop.text else {return}
        guard let email = txfEmail.text else {return}
        guard let phoneNumber = txfPhoneNumber.text else {return}
        guard let address = txfAddress.text else {return}
        guard let password = txfPassword.text else {return}
        guard txfConfirmPass.text != nil else {return}
        
        deviceToken = "afasdfasdf9872439729"
        
        let sellerSignUpParam = sellerSignUpModel(Full_Name: name, Email: email, Mobile: phoneNumber, Password: password, Role: "Buyer", device_token: deviceToken!, mobileType: "iOS", gender: "male", profile_image: "", open_time: "", close_time: "", shop_description: "", address: address)
        
        APIManger.shareInstance.callingSellerSignUpAPI(sellerSignUp: sellerSignUpParam) {(result) in
            
            
            switch result{
            case .success(let json):
                print(json!)
                
                let status = (json as! sellerSignUpResponse).status
                if status == "success" {
                    let text = (json as! sellerSignUpResponse).smsResponse.text
                    print("Verfication code is: ",text)
                    
                    let mobileNumber = (json as! sellerSignUpResponse).userinfo.Mobile
                    let Validation_Code = (json as! sellerSignUpResponse).userinfo.Validation_Code
                    let defaults = UserDefaults.standard
                    defaults.set(mobileNumber, forKey: "Defaultsmobile")
                    defaults.set(Validation_Code, forKey: "DefaultsOtp")
                    
                    //Go to verfication view controller
                    
                    DispatchQueue.main.async {
                        self.GotoVerficationController()
                    }
                    
                    
                    
                }else {
                    print("SignUp Error")
                }
                
                
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            
            
            
        }
        
        
        
        
    }
}


extension SignupVC {
    func GotoVerficationController(){
        
        let sellerStoryBoard = UIStoryboard(name: "SellerStoryboard", bundle:nil)
        let verfication = sellerStoryBoard.instantiateViewController(identifier: "SellerSignUpVerficationVC")as! SellerSignUpVerficationVC
        self.navigationController?.pushViewController(verfication, animated: true)
    }
}
