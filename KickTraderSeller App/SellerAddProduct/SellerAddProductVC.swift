//
//  SellerAddProductVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 11/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire

class SellerAddProductVC: UIViewController {
    
    @IBOutlet var imgProductCover: UIImageView!
    @IBOutlet var btnPicture: UIButton!
    @IBOutlet var btnVideo: UIButton!
    @IBOutlet var txfName: UITextField!
    @IBOutlet var txfPrice: UITextField!
    @IBOutlet var txvDescription: UITextView!
    @IBOutlet var btnCategory: UIButton!
    @IBOutlet var btnSubCategory: UIButton!
    
    @IBOutlet var btnBrand: UIButton!
    
    
    
    var imagePicker = UIImagePickerController()
    var videoURL : NSURL?
    var checkButton: String?
    var subCategory: String?
    var categoryRef: String?
    var brandRef: String?
    var defaults = UserDefaults.standard
    
    private var alertController = UIAlertController()
    private var tblView = UITableView()
   
    
    var arrCategories = [Category]()
    var arrbrands = [Brand]()
    var arrsize = [Size]()
    var arrcolor = [Color]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        self.getAllDropdownListAPI()
    }
    
    
}

extension SellerAddProductVC {
    func getAllDropdownListAPI(){
        
        ProgressHUD.show()
        APIManger.shareInstance.callingGetAllDropdownListAPI() { [self](result) in
            
            switch result{
            case.success(let json):
               // print(json!)
                
            ProgressHUD.dismiss()
                self.arrCategories = ((json as! Welcome).array?.categories!)!
             //   print("Categories are: ",self.arrCategories)
                
                
                self.arrbrands = ((json as! Welcome).array?.brands!)!
               // print("Brands are: ",arrbrands)
            
            
            arrcolor = ((json as! Welcome).array?.color!)!
                
             arrsize = ((json as! Welcome).array?.size!)!
      
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
}

//MARK:- UITableView DataSource & Delegate
extension SellerAddProductVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if checkButton == "1" {
            return arrCategories.count
        }
        else{
            return arrbrands.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        if checkButton == "1"{
          
            let categoryModel = arrCategories[indexPath.row]
            cell.textLabel!.text = categoryModel.category_Name
            return cell
        }
        
       
        else {
            let brandModel =  arrbrands[indexPath.row]
            cell.textLabel?.text = brandModel.brandName
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if checkButton == "1"{
            btnCategory.setTitle(arrCategories[indexPath.row].category_Name, for: .normal)
            categoryRef = arrCategories[indexPath.row].category_uniqid
        }
        
        
        
        else if checkButton == "2" {
            btnBrand.setTitle(arrbrands[indexPath.row].brandName,for:.normal)
            brandRef = arrbrands[indexPath.row].brandRef
        }
        
    }
}



//MARK:- Helper Method

extension SellerAddProductVC {
    
    func OpenCameraMenu()  {
        

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
              
              alertController.addAction(action1)
              alertController.addAction(action2)
              alertController.addAction(maybeAction)
              
              self.present(alertController, animated: true, completion: nil)
              
    }
    
    
    //TODO:- Show Category Menu
    func ShowActionSheetOfCategory() {
      
            let alertVC = UIViewController.init()
            let rect = CGRect(x: 0, y: 0, width: 500.0, height: 400.0)
            alertVC.preferredContentSize = rect.size
            
            tblView = UITableView(frame: rect)
            tblView.delegate = self;
            tblView.dataSource = self;
            tblView.tableFooterView = UIView(frame: .zero)
            tblView.separatorStyle = .singleLine
            alertVC.view.addSubview(tblView)
            alertVC.view.bringSubviewToFront(tblView)
            alertVC.view.isUserInteractionEnabled = true
            tblView.isUserInteractionEnabled = true
            tblView.allowsSelection = true
            
            self.alertController = UIAlertController(title: "Category", message: nil, preferredStyle: .alert)
            alertController.setValue(alertVC, forKey: "contentViewController")
            
            let cancelAction = UIAlertAction(title: "Submit", style: .default, handler: nil)
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func ShowSubCategory(){
        let alert = UIAlertController(title: "KickTraders", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Male", style: .default , handler:{ (UIAlertAction)in
                self.subCategory = "1"
                print("User click Male button ",self.subCategory! as String)
            }))
            
            alert.addAction(UIAlertAction(title: "Female", style: .default , handler:{ (UIAlertAction)in
                self.subCategory = "2"
                print("User click Female button",self.subCategory! as String)
            }))

            alert.addAction(UIAlertAction(title: "Both", style: .destructive , handler:{ (UIAlertAction)in
                self.subCategory = "3"
                print("User click Both button",self.subCategory! as String)
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                print("User click Dismiss button")
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
    
    
}

//MARK:- UIImagePicker Methods
extension SellerAddProductVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
    
    
    
    func OpenVideoFromGallary(){
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.videoMaximumDuration = 10 // or whatever you want
        imagePicker.videoQuality = .typeLow
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: — ImagePicker delegate
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImg = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            //save image ?? Display Image
            imgProductCover.image = selectedImg

        }
        self.dismiss(animated: true, completion: nil)
    }
    
 
}



// MARK:- UIBUTTON ACTION
extension SellerAddProductVC {
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionPhotoClicked(_ sender: Any) {
        self.OpenCameraMenu()
    }
    
    @IBAction func actionVideoClicked(_ sender: Any) {
        OpenVideoFromGallary()
    }
    
    @IBAction func actionCategoryClicked(_ sender: Any) {
        checkButton = "1"
        self.ShowActionSheetOfCategory()
    }
    
    @IBAction func actionSubCategory(_ sender: Any) {
        self.ShowSubCategory()
    }
    
    @IBAction func actionBrand(_ sender: Any) {
        checkButton = "2"
        self.ShowActionSheetOfCategory()
    }

    @IBAction func actionAddProductClicked(_ sender: Any){

        if txfName.text == "" {showAlert(alertMessage: "Please enter all detail")}
        if txfPrice.text == "" {showAlert(alertMessage: "Please enter all detail")}
        if txvDescription.text == "" {showAlert(alertMessage: "Please enter all detail")}
        if txvDescription.text == "" {showAlert(alertMessage: "Please enter all detail")}
        if imgProductCover.image == nil {showAlert(alertMessage: "Please enter all detail")}
        else {
            self.SellerAddProductApiCalling()
        }
    }
}


//TODO:- Update User Info API
extension SellerAddProductVC{
    func SellerAddProductApiCalling(){
        ProgressHUD.show("Updating.", interaction: false)
        
        //Set Your URL
        let api_url = SellerAddProduect_url
        guard let url = URL(string: api_url) else {
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //Set Your Parameter
        let parameterDict = NSMutableDictionary()
        
        parameterDict.setValue(txfName.text, forKey: "name")
        parameterDict.setValue(categoryRef!, forKey: "categoryRef")
        parameterDict.setValue(subCategory!, forKey: "subCategory")
        
        
        
        parameterDict.setValue(txfPrice.text, forKey: "price")
        parameterDict.setValue(brandRef!, forKey: "brandRef")
        parameterDict.setValue(txvDescription.text, forKey: "description")
        parameterDict.setValue("", forKey: "productVideo")
      
        parameterDict.setValue(defaults.value(forKey:"DefaultssellerRef") ,forKey: "sellerRef")
       
        print(parameterDict)
        //Set Image Data
        
        guard let imgData = imgProductCover.image!.jpegData(compressionQuality: 0.75) else { return }
        
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
            multiPart.append(imgData, withName: "productCoverImage", fileName: "file2.png", mimeType: "image/png")
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


