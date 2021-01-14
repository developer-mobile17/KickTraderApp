//
//  LoginVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import CircleBar
class LoginVC: UIViewController {
    
    @IBOutlet var txfEmail: UITextField!
    @IBOutlet var txfPassword: UITextField!
    
    var statusResponse: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txfEmail.text = "buyer@gmail.com"
       // txfEmail.text = "iOS@gmail.com"
        txfPassword.text = "1234"
        txfPassword.isSecureTextEntry = false
        
        
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Custom Method
extension LoginVC {
    
    func goToBuyerHome(){
        let TabbarVC = self.storyboard?.instantiateViewController(identifier: "mainTabVC") as! mainTabVC
        
        self.navigationController?.pushViewController(TabbarVC, animated: true)
    }
    
    func goToSellerHome(){
        let sellerStoryBoard = UIStoryboard(name: "SellerStoryboard", bundle:nil)
        let  sellerStoryVC = sellerStoryBoard.instantiateViewController(identifier: "SellerMainTab")
        self.navigationController?.pushViewController(sellerStoryVC, animated: true)
    }
    
}


//MARK:- UIButton Action
extension LoginVC {
    @IBAction func actionLogin(_ sender: Any) {
        
        
        if InternetConnectionManager.isConnectedToNetwork()
        {
            self.LoginAPICalling()
            
        }
        else {
            ProgressHUD.dismiss()
            self.showAlert(alertMessage: "Internet connection is not available!")
            
        }
        
        
    }
    
    @IBAction func actionForgotPass(_ sender: Any) {
        
        
        let vwForgot = self.storyboard?.instantiateViewController(identifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(vwForgot, animated: true)
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        
        
        let vwTypeOfAccount = self.storyboard?.instantiateViewController(identifier: "TypeOfAccountVC") as! TypeOfAccountVC
        self.navigationController?.pushViewController(vwTypeOfAccount, animated: true)
    }
}


extension LoginVC {
    func LoginAPICalling(){
      
        
        guard let email = txfEmail.text else {return}
        guard let password =  txfPassword.text else {return showAlert(alertMessage: "Please Enter Password")}
        
        let loginn = loginModel(Password: password, Role: "", FieldType: "Email", Email: email, deviceToken: "jfalsjdflksjd4124IOS", mobileType: "iOS")
        
        ProgressHUD.show("Loading...", interaction: false)
        
        APIManger.shareInstance.callingLoginAPI(loginCheck: loginn) { [self](result) in
            
            switch result{
            case.success(let json):
               // print(json!)
                
                ProgressHUD.dismiss()
                
                statusResponse = (json as! loginModelResponse).status
                if statusResponse == "error" {
                  //  print("Status Response:",(json as! loginModelResponse).msg!)
                    showAlert(alertMessage:(json as! loginModelResponse).msg!)
                }
                else {
                    
                    
                    let role = (json as! loginModelResponse).userInfo?.role
                  //  print(role!)
                    let baseURL = (json as! loginModelResponse).base_url
                    let buyerRef = (json as! loginModelResponse).userInfo?.userRef
                    let userImg = (json as! loginModelResponse).userInfo?.profile_Image
                    
                    let defaults = UserDefaults.standard
                    defaults.set(baseURL, forKey: "DefaultsBaseURL")
                    defaults.set(buyerRef, forKey: "DefaultsbuyerRef")
                    defaults.setValue(userImg, forKey: "Defaultsprofile_Image")
                    
                    
                    
                    if role == "Seller" {
                        defaults.set(buyerRef, forKey: "DefaultssellerRef")
                        self.goToSellerHome()
                    } else{
                        
                        self.goToBuyerHome()
                    }
                    
                }
                
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
}
