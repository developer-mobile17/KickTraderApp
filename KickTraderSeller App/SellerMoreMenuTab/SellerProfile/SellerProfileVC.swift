//
//  SellerProfileVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 05/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SellerProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet var imgProfile : UIImageView!
    @IBOutlet var txfName : UITextField!
    @IBOutlet var txfEmail : UITextField!
    @IBOutlet var txfPhoneNumber : UITextField!
    @IBOutlet var txfAddress : UITextField!
    @IBOutlet var btnsGenderSelect: [UIButton]!
    @IBOutlet var txvDesc : UITextView!
    @IBOutlet var btnOpenTime : UIButton!
    @IBOutlet var btnCloseTime : UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var dateFormatter = DateFormatter()
    var datePicker: UIDatePicker?
    var selectedGender: String?
    var checkShopTime : String?
    var selectedOpenTime: String?
    var selectedCloseTime: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Profile"
        self.CallingGetUserInfoAPI()
    }
    
    
    @IBAction func actionSelectPhoto(_ sender: Any) {
        self.OpenProfileCameraMenu()
    }
    
    @IBAction func actionGenderClicked(_ sender: UIButton) {
        
        btnsGenderSelect.forEach{
            $0.isSelected = false
        }
        sender.isSelected.toggle()
        
        if sender.tag == 1 {
            selectedGender = "Male"
            print(" Gender is 👦🏼")
            
        }
        else if sender.tag == 2{
            selectedGender = "FeMale"
            print(" Gender is 👩🏻")
            
        }
        else{
            selectedGender = "Both"
            print(" Gender is 🤷🏻")
        }
        
        
    }
    
    
    //TODO:- Action Open Time Get
    @IBAction func actionOpenTime(_ sender: Any) {
        
        checkShopTime = "OpenTime"
        
        datePicker = UIDatePicker()
        datePicker?.date = Date()
        datePicker?.locale = Locale(identifier: "en_US")
        datePicker?.datePickerMode = .time
        datePicker?.preferredDatePickerStyle = .automatic
        datePicker?.tintColor = .white
        datePicker?.backgroundColor = .black
        datePicker?.tintColorDidChange()
        datePicker?.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        addDatePickerAsSubview()
       
    }
    
    
    
    //TODO:- Action Close Time Get
    @IBAction func actionCloseTime(_ sender: Any) {
        checkShopTime = "CloseTime"
        
        datePicker = UIDatePicker()
        datePicker?.date = Date()
        datePicker?.locale = Locale(identifier: "en_US")
        datePicker?.datePickerMode = .time
        datePicker?.preferredDatePickerStyle = .automatic
        datePicker?.tintColor = .white
        datePicker?.backgroundColor = .black
        datePicker?.tintColorDidChange()
        datePicker?.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        addDatePickerAsSubview()
       
    }
    
    
    @IBAction func actionUpdateUserInfo(_ sender: Any) {
        self.CallingUpdateUserInfoAPI()
    }
    
    
    
    func addDatePickerAsSubview() {
         guard let datePicker = datePicker else { return }
        
        
        if checkShopTime == "OpenTime" {
            self.btnOpenTime.addSubview(datePicker)
        }
        else {
            self.btnCloseTime.addSubview(datePicker)
        }
        
         datePicker.translatesAutoresizingMaskIntoConstraints = false
        
     }
     
    
       @objc func handleDateSelection() {
        
        guard let picker = datePicker else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        
        if  checkShopTime == "OpenTime" {
            selectedOpenTime = dateFormatter.string(from: picker.date)
            print("Selected Open date/time:",selectedOpenTime!)
        }
        
        else {
         
            selectedCloseTime = dateFormatter.string(from: picker.date)
            print("Selected CLose date/time:",selectedCloseTime!)
        }
       }
    
}


//TODO:- WebAPI Calling :- GetUserInfo
extension SellerProfileVC {
    func CallingGetUserInfoAPI(){
        
        ProgressHUD.show("Loading.", interaction: false)
        
        let getUserInfoParam = getUserInfoModel(Value: UserDefaults.standard.value(forKey: "DefaultssellerRef") as! String, Key: "userRef")
        
        BuyerAPIManager.shareInstance.callingGetUserInfoAPI(getUserInfoParam: getUserInfoParam) {(result) in
            
            switch result{
            case.success(let json):
                   print(json!)
                
                
                //TODO:- Update the UI with User Info...
                let img = (json as! getUserInfoModelResponse).userInfo?.profile_Image!
                print(img!)
                let imgProfileURL =  URL(string:"\(PROFILE_IMAGE)\(img!)")
                self.imgProfile.kf.setImage(with:imgProfileURL!)
                
                self.txfName.text = (json as! getUserInfoModelResponse).userInfo?.full_Name
                self.txfEmail.text = (json as! getUserInfoModelResponse).userInfo?.email
                self.txfPhoneNumber.text = (json as! getUserInfoModelResponse).userInfo?.mobile
                self.txfAddress.text = (json as! getUserInfoModelResponse).userInfo?.address
                self.txvDesc.text = (json as! getUserInfoModelResponse).userInfo?.shop_description
                self.btnOpenTime.setTitle((json as! getUserInfoModelResponse).userInfo?.open_time, for: .normal)
                self.btnCloseTime.setTitle((json as! getUserInfoModelResponse).userInfo?.close_time, for: .normal)
                
              //  7hy2xYA0Aa763
                
                ProgressHUD.dismiss()
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}


//TODO:- Update User Info API
extension SellerProfileVC{
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
        
        
        
        parameterDict.setValue(selectedGender, forKey: "gender")
        parameterDict.setValue(selectedOpenTime, forKey: "open_time")
        parameterDict.setValue(selectedCloseTime, forKey: "close_time")
        parameterDict.setValue(self.txvDesc.text, forKey: "shop_description")
        parameterDict.setValue(txfAddress.text, forKey: "address")
        parameterDict.setValue(UserDefaults.standard.value(forKey:"DefaultssellerRef") ,forKey: "userRef")
       
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

extension SellerProfileVC {
    
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
extension SellerProfileVC {
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

