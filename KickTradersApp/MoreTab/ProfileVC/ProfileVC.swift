//
//  ProfileVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var txfName: UITextField!
    @IBOutlet var txfEmail: UITextField!
    @IBOutlet var txfPhoneNumber: UITextField!
    
    @IBOutlet var txfAddress: UITextField!
    var imagePicker = UIImagePickerController()
    var defaultProfile = UserDefaults.standard
    var SelectedProfileImg = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        self.CallingGetUserInfoAPI()

    }

    
    @IBAction func actionChooseProfileImg(_ sender: Any) {
        self.OpenProfileCameraMenu()
    }
    //TODO:- UIButton Action
    @IBAction func actionSaveChanges(_ sender: Any) {
        self.CallingUpdateUserInfoAPI()
    }




    
}


//TODO:- WebAPI Calling :- GetUserInfo
extension ProfileVC {
    func CallingGetUserInfoAPI(){
        
        ProgressHUD.show("Loading.", interaction: false)
        
        let getUserInfoParam = getUserInfoModel(Value: defaultProfile.value(forKey:"DefaultsbuyerRef") as! String, Key: "userRef")
        
        BuyerAPIManager.shareInstance.callingGetUserInfoAPI(getUserInfoParam: getUserInfoParam) {(result) in
            
            switch result{
            case.success(let json):
                //   print(json!)
                
                
                //TODO:- Update the UI with User Info...
                
                self.imgProfile.showLoading(color: .systemRed)
                DispatchQueue.main.async {
                    let img = (json as! getUserInfoModelResponse).userInfo?.profile_Image!
                    print(img!)
                    let imgProfileURL =  URL(string:"\(PROFILE_IMAGE)\(img!)")
                   
                    self.imgProfile.kf.setImage(with:imgProfileURL!)
                    
                    self.imgProfile.stopLoading()
                }
                
                
                
                self.txfName.text = (json as! getUserInfoModelResponse).userInfo?.full_Name
                self.txfEmail.text = (json as! getUserInfoModelResponse).userInfo?.email
                self.txfPhoneNumber.text = (json as! getUserInfoModelResponse).userInfo?.mobile
                self.txfAddress.text = (json as! getUserInfoModelResponse).userInfo?.address
                
                
                
                ProgressHUD.dismiss()
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}
//TODO:- Update User Info API
extension ProfileVC{
    func CallingUpdateUserInfoAPI(){
        
        ProgressHUD.show("Updating.", interaction: false)
        //Set Your URL
        let api_url = UpdateUserInfo_url
        guard let url = URL(string: api_url) else {
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //Set Your Parameter
        let parameterDict = NSMutableDictionary()
        parameterDict.setValue(txfName.text, forKey: "Full_Name")
        parameterDict.setValue(txfEmail.text, forKey: "Email")
        parameterDict.setValue(txfPhoneNumber.text, forKey: "Mobile")
        
        
        
        parameterDict.setValue("male", forKey: "gender")
        parameterDict.setValue("", forKey: "open_time")
        parameterDict.setValue("", forKey: "close_time")
        parameterDict.setValue("", forKey: "shop_description")
        parameterDict.setValue(txfAddress.text, forKey: "address")
        parameterDict.setValue(defaultProfile.value(forKey:"DefaultsbuyerRef") ,forKey: "userRef")
       
        //   parameterDict.setValue(selectedImage!, forKey: "image")
        
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
            multiPart.append(imgData!, withName: "Profile_Image", fileName: "file2.png", mimeType: "image/png")
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

                    AppSnackBar.make(in: self.view, message:"Profile updated successfully.", duration: .lengthShort).show()
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

extension ProfileVC {
    
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
              
//              action1.setValue(UIColor.purple, forKey: "titleTextColor")
//              action2.setValue(UIColor.green, forKey: "titleTextColor")
            
              alertController.addAction(action1)
              alertController.addAction(action2)
              alertController.addAction(maybeAction)
              
              self.present(alertController, animated: true, completion: nil)
              
    }
}


//MARK:- UIImagePicker Methods
extension ProfileVC {
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


