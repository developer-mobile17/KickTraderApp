//
//  SignupVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import Alamofire
class SignupVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var txfShop: UITextField!
    @IBOutlet var txfEmail: UITextField!
    @IBOutlet var txfPhoneNumber: UITextField!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var txfPassword: UITextField!
    @IBOutlet var txfConfirmPass: UITextField!
    @IBOutlet var btnGender: UIButton!
    

    var imagePicker = UIImagePickerController()
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

    }
    
    @IBAction func actionGenderSelect(_ sender: Any) {

        let image = UIImage(named: "Group 1")
        let action = UIAlertAction(title: "title", style: .default, handler: nil)
        action.setValue(image, forKey: "image")
        alert.addAction(action)
    }
    
    @IBAction func actionChooseProfileImg(_ sender: Any) {
        self.OpenProfileCameraMenu()
    }




    
}

//MARK:- UIButton Action
extension SignupVC {

    @IBAction func actionLogin(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func actionBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }


    @IBAction func actionSignUp(_ sender: Any) {


        if txfShop.text == "" || txfEmail.text == "" || txfPhoneNumber.text == "" || txfAddress.text == "" || txfPassword.text == ""  {
            showAlert(alertMessage: "All fileds are required.")
        }

        else {
            DispatchQueue.main.async {
                self.signUpAPICalling()
            }
        }


    }



}


//MARK:- API Calling...
extension SignupVC {
    func signUpAPICalling (){
        
       let deviceToken =  UserDefaults.standard.value(forKey: "AppDeviceToken") ?? "askldfjksdjfjkfj"
        
        ProgressHUD.show("Please Wait.", interaction: false)
        //Set Your URL
        let api_url = sellerSignUp_url
        guard let url = URL(string: api_url) else {
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //Set Your Parameter
        let parameterDict = NSMutableDictionary()
        parameterDict.setValue(txfShop.text, forKey: "Full_Name")
        parameterDict.setValue(txfEmail.text, forKey: "Email")
        parameterDict.setValue(txfPhoneNumber.text, forKey: "Mobile")
        parameterDict.setValue("male", forKey: "gender")
        parameterDict.setValue(txfPassword.text, forKey: "Password")
        parameterDict.setValue("Buyer", forKey: "Role")
        
        parameterDict.setValue(deviceToken, forKey: "deviceToken")
        parameterDict.setValue("iOS", forKey: "mobileType")
        
        
        parameterDict.setValue("", forKey: "open_time")
        parameterDict.setValue("", forKey: "close_time")
        parameterDict.setValue("", forKey: "shop_description")
        parameterDict.setValue(txfAddress.text, forKey: "address")
        
        
        print(parameterDict)
        //Set Image Data
        
        let imgData = imgProfile.image!.jpegData(compressionQuality: 0.75)
        
        //  let imgData = imgProfile.image!.jpegData(compressionQuality: 0.75)
        
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameterDict {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key as! String)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key as! String)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key as! String + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(imgData!, withName: "profile_image", fileName: "file.png", mimeType: "image/png")
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            
            switch data.result {
            
            case .success(_):
                do {
                    
                    let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                    
                    print("Success!")
                    print(dictionary)
                    ProgressHUD.dismiss()
                    
                    
                    
                    
                    let status = dictionary.object(forKey: "status") as! String
                    if status == "success" {
                        
                        let smsResponse = dictionary.object(forKey: "sms_response") as! NSDictionary
                        let text = smsResponse.object(forKey: "text") as! String
                        print("sms_Response is: ",text)
                        
                        //   self.showAlert(alertMessage: text)
                        
                        
                        let userInfo = dictionary.object(forKey: "UserInfo") as! NSDictionary
                        let Validation_Code = userInfo.object(forKey: "Validation_Code") as! String
                        print("Verfication code is: ",Validation_Code)
                        let mobileNumber = userInfo.object(forKey: "Mobile") as! String
                        
                        let defaults = UserDefaults.standard
                        defaults.set(mobileNumber, forKey: "Defaultsmobile")
                        defaults.set(Validation_Code, forKey: "DefaultsOtp")
                        
                        DispatchQueue.main.async {
                            self.GotoVerficationController()
                        }
                        //                       2
                    }
                    else {
                        self.showAlert(alertMessage: dictionary.object(forKey: "msg") as! String)
                    }
                }
                catch {
                    // catch error.
                    ProgressHUD.dismiss()
                    print("catch error")
                    
                }
                break
                
            case .failure(_):
                ProgressHUD.dismiss()
                print("failure")
                
                break
                
            }
            
            
        })
        
        
        
    }
}




//MARK:- Helper Method

extension SignupVC {
    
    func OpenProfileCameraMenu()  {
        
        
        let alertController = UIAlertController(title: nil, message: "Select Photos ", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Open Camera", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            print("Open Camera")
            self.OpenCamera()
        })
        
        let action2 = UIAlertAction(title: "Open Gallery", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            print("Open Gallery")
            self.OpenGallery()
        })
        
        
        let maybeAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        action1.setValue(UIColor.purple, forKey: "titleTextColor")
        action2.setValue(UIColor.green, forKey: "titleTextColor")
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(maybeAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}


//MARK:- UIImagePicker Methods
extension SignupVC {
    func OpenCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("No Camera Found...!")
        }
        
    }
    
    
    func OpenGallery(){
        UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    //MARK: — ImagePicker delegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImg = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            //save image ?? Display Image
            imgProfile.image = selectedImg
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignupVC {
    func GotoVerficationController(){
        
        let sellerStoryBoard = UIStoryboard(name: "SellerStoryboard", bundle:nil)
        let verfication = sellerStoryBoard.instantiateViewController(identifier: "SellerSignUpVerficationVC")as! SellerSignUpVerficationVC
        self.navigationController?.pushViewController(verfication, animated: true)
    }
}
