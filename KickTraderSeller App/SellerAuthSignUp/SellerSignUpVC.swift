//
//  SellerSignUpVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 18/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SellerSignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var objScroll: UIScrollView!
    @IBOutlet var txfEmail: UITextField!
    @IBOutlet var txfShop: UITextField!
    @IBOutlet var txfPhone: UITextField!
    @IBOutlet var txfAddress: UITextField!
    @IBOutlet var btnsGender: [UIButton]!
    @IBOutlet var txfPassword: UITextField!
    @IBOutlet var txfConfirmPassword: UITextField!
    @IBOutlet var txvDescription: UITextView!
    
    var imagePicker = UIImagePickerController()
    var deviceToken:String?
    var genderSelected:String?
    var openTimeSelected: String?
    var closeTimeSelected: String?
    let defaults = UserDefaults.standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        deviceToken = "sdfdskjfhdskjhfsdsd"
        
        objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height:1000))

    }
    
    
    @IBAction func actionSelectPhoto(_ sender: Any) {
        self.OpenProfileCameraMenu()
    }

    @IBAction func actionGenderSelect(_ sender: UIButton) {
        
        btnsGender.forEach{
            $0.isSelected = false
        }
        sender.isSelected.toggle()
        
        if sender.tag == 1 {
            genderSelected = "Male"
            print(" Gender is 👦🏼")
            
        }
        else if sender.tag == 2{
            genderSelected = "FeMale"
            print(" Gender is 👩🏻")
            
        }
        else{
            genderSelected = "Both"
            print(" Gender is 🤷🏻")
        }
        
       
    }
    
    @IBAction func actionOpenTime(_ sender: Any) {
        openTimeSelected = "10:00am"
    }
    @IBAction func actionCloseTime(_ sender: Any) {
        closeTimeSelected = "10:00pm"
    }
    @IBAction func actionSignUp(_ sender: Any) {
        
        self .sellerSignUpAPICalling()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SellerSignUpVC {
    func sellerSignUpAPICalling (){
        
        guard  let shop = txfShop.text else {return}
        guard  let email = txfEmail.text else {return}
        guard  let phoneNumber = txfPhone.text else {return}
        guard  let address = txfAddress.text else {return}
        guard  let password = txfPassword.text else {return}
        guard  txfConfirmPassword.text != nil else {return}
        guard  let description = txvDescription.text else {return}
        
        let sellerSignUpParam = sellerSignUpModel(Full_Name: shop, Email: email, Mobile: phoneNumber, Password: password, Role: "Seller", device_token: deviceToken!, mobileType: "iOS", gender: genderSelected!, profile_image: "", open_time: openTimeSelected!, close_time: closeTimeSelected!, shop_description: description, address: address)
        
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
                   
                    self.defaults.set(mobileNumber, forKey: "Defaultsmobile")
                    self.defaults.set(Validation_Code, forKey: "DefaultsOtp")

                    //Go to verfication view controller
                    
                    DispatchQueue.main.async {
                        self.GotoVerfication()
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
extension SellerSignUpVC {
    func GotoVerfication(){
        
        let sellerStoryBoard = UIStoryboard(name: "SellerStoryboard", bundle:nil)
        let verfication = sellerStoryBoard.instantiateViewController(identifier: "SellerSignUpVerficationVC")as! SellerSignUpVerficationVC
        self.navigationController?.pushViewController(verfication, animated: true)
    }
}


//MARK:- Helper Method

extension SellerSignUpVC {
    
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
extension SellerSignUpVC {
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
