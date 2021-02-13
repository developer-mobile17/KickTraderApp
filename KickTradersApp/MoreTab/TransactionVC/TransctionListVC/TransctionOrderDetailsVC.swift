//
//  TransctionOrderDetailsVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 08/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import SnapKit
import SnackBar_swift
import Alamofire
import MobileCoreServices

class AppSnackBar: SnackBar {

    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .black
        style.textColor = .white
        return style
    }
}

class TransctionOrderDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //TODO: Buyer/Product Data
    var strProductRef : String!
    var strproductName : String!
    var strbrandName : String!
    var strproductCoverImage : String!
    var strcolorCode : String!
    var strbidPrice : String!
    var strSize : String!
    var strOrderStatus : String!
    var strOrderNumber: String!

    var strAuthenticationProductStatus:String!
    
    @IBOutlet var btnUnboxingVideo: UIButton!
    @IBOutlet var btnCancelOrder: UIButton!
    @IBOutlet var btnTrackOrder: UIButton!
    @IBOutlet var btnAddRating: UIButton!
    @IBOutlet var btnAddAuthentication: UIButton!
    
    @IBOutlet var lblOrderStatus: UILabel!
    @IBOutlet var imgShoes: UIImageView!
    @IBOutlet var lblShoeBrandName: UILabel!
    @IBOutlet var lblShoeName: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    
    let imagePickerController = UIImagePickerController()
    var videoUrl:URL?
    var videoUrlData:Data?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        print(strOrderNumber!)
        print(strProductRef!)

       
        btnUnboxingVideo.isHidden = false
        btnAddRating.isHidden = true
        btnCancelOrder.isHidden = true
        btnTrackOrder.isHidden = true
        btnAddAuthentication.isHidden = true
        ShowOrderDetails()

      
    }
    

    @IBAction func actionAddAuthentication(_ sender: Any) {

        // 1
        let optionMenu = UIAlertController(title: nil, message:"\("Add Authentication for") \(String(describing: strproductName!))", preferredStyle: .actionSheet)
           // 2
        let geniuneAction = UIAlertAction(title: "Product is geniune", style: .default , handler: { (alert: UIAlertAction!) -> Void in
            print("Product is Geniune")
            self.strAuthenticationProductStatus = "1"
            self.addAuthenticationAPI()

        })
           let fakeAction = UIAlertAction(title: "Product is fake", style: .default , handler: { (alert: UIAlertAction!) -> Void in
            print("Product is Fake")
            self.strAuthenticationProductStatus = "0"
            self.addAuthenticationAPI()

        })
           // 3
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

           // 4
           optionMenu.addAction(geniuneAction)
           optionMenu.addAction(fakeAction)
           optionMenu.addAction(cancelAction)

           // 5
           self.present(optionMenu, animated: true, completion: nil)

    }
    
}

//MARK:- UIButton Action
extension TransctionOrderDetailsVC  {

    @IBAction func actionback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actoinAddUnboxingVideo(_ sender: Any) {

       // self.showVideoPicker()
        self.showImagePicker()

    }
    
    @IBAction func actionRating(_ sender: Any) {
        
        let vcRating = self.storyboard?.instantiateViewController(identifier: "RateSellerVC") as! RateSellerVC
        self.navigationController?.pushViewController(vcRating, animated: true)
        
        
    }
    
    @IBAction func actionTrackOrder(_ sender: Any) {
        self.goToTrackOrderClass()
    }
    
    
    @IBAction func actionCancelOrder(_ sender: Any) {
        ProgressHUD.show("Please wait.",  interaction: false)
        DispatchQueue.main.async {
            self.cancelOrderAPI()
        }
    }

    @IBAction func actionTapDispute(_ sender: Any)
    {

        guard let vcAddDispute = storyboard?.instantiateViewController(identifier: "DisputeViewVC") as? DisputeViewVC else{

            return
        }

        present(vcAddDispute, animated: true)
    }
}

extension TransctionOrderDetailsVC {
    func ShowOrderDetails(){
        
        // Show Product info
        if let imgProduct =  URL(string:"\(PRODUCT_COVER_IMAGE)\(strproductCoverImage ?? "")") {
            self.imgShoes.kf.setImage(with:imgProduct)
        }
        else {

            self.imgShoes.image = UIImage(imageLiteralResourceName:"NoImg.png")
        }

        lblShoeBrandName.text = strbrandName
        lblShoeName.text = strproductName
        lblSize.text = strSize
        lblPrice.text = "\("Bid Price:$") \(String(describing: strbidPrice!))"
        if let colorCode = strcolorCode ?? "" {
            lblColor.backgroundColor = UIColor(hexFromString: colorCode)

        }
       // lblColor.backgroundColor = UIColor(hexFromString:strcolorCode)
        
        if strOrderStatus == "pending"{
            print("Pending")
            lblOrderStatus.text = strOrderStatus.capitalized
            lblOrderStatus.textColor = UIColor.systemYellow
            btnCancelOrder.isHidden = false
            btnTrackOrder.isHidden = false
        }
        
        else if strOrderStatus == "cancelled"{
            print("cancelled")
            lblOrderStatus.text = strOrderStatus.capitalized
            lblOrderStatus.textColor = UIColor.systemRed
        }
        else {
            print("Delivered")
            lblOrderStatus.text = strOrderStatus.capitalized
            lblOrderStatus.textColor = UIColor.systemGreen
            
            btnUnboxingVideo.isHidden = false
            btnAddRating.isHidden = false
            btnTrackOrder.isHidden = false
            btnAddAuthentication.isHidden = false
        }
        }
        
        
        
    }



//MARK:- add Authentication API
extension TransctionOrderDetailsVC {
    func addAuthenticationAPI(){

        let addAuthenticationParam = addAuthenticationRequest(userRef:UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String, productRef: strProductRef, orderNumber: strOrderNumber, status: strAuthenticationProductStatus)
        BuyerAPIManager.shareInstance.callingAddAuthentication_API(addAuthenticationParam: addAuthenticationParam) { (result) in

            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                if let msg = (json as! addAuthenticationResponse).msg{
                    self.showAlert(alertMessage:msg)
                print(msg)
                }

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }


    }
}
    
//MARK:- Cancel API
extension TransctionOrderDetailsVC {
    func cancelOrderAPI(){
        
       let cancelOrderParam = cancelOrderModel(orderNumber: strOrderNumber)
        
        BuyerAPIManager.shareInstance.cancelOrderAPI(cancelOrderParam:cancelOrderParam) { (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                
             
                let status = (json as! cancelOrderModelResponse).status
                if status == "success" {
                    print("msg: ",(json as! cancelOrderModelResponse).msg)
                    self.navigationController?.popViewController(animated: true)
                }
                print(status)
                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
        
    }
}


//MARK:- Track Order
extension TransctionOrderDetailsVC {
    func goToTrackOrderClass(){

        let vcTrackOrder = self.storyboard?.instantiateViewController(identifier: "TrackOrderVC") as! TrackOrderVC
        self.navigationController?.pushViewController(vcTrackOrder, animated: true)

    }
}


extension TransctionOrderDetailsVC{


    func showVideoPicker() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)

    }






//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            dismiss(animated: true, completion: nil)
//            guard let movieUrl = info[.mediaURL] as? URL else { return }
//            print(movieUrl)
//        self.videoUrl = movieUrl as URL
//        DispatchQueue.main.async {
//            self.uploadVideoFile()
//        }
//
//            // work with the video URL
//    }
//


    func showImagePicker(){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.mediaTypes = [kUTTypeMovie as String]
            self.present(picker, animated: true, completion: nil)
        }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                picker.dismiss(animated: true, completion: nil)

        guard let videoUrl = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaURL.rawValue)] as? URL else {
                    return
                }
                do {
                    let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                    print(data)
                    videoUrlData = data
                    self.uploadVideoFile()
    //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
                }
                catch
                {
                }
            }

    func uploadVideoFile() {

        ProgressHUD.show("Updating.", interaction: false)
        //Set Your URL
        let api_url = addUnboxingVideo_Url
        guard let url = URL(string: api_url) else {
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")


        //Set Your Parameter
        let parameterDict = NSMutableDictionary()
        parameterDict.setValue(strOrderNumber, forKey: "orderRef")

        parameterDict.setValue(UserDefaults.standard.value(forKey:"DefaultsbuyerRef") ,forKey:"buyerRef")

        //   parameterDict.setValue(selectedImage!, forKey: "image")

        print(parameterDict)
        //Set Image Data


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

            
            multiPart.append(self.videoUrlData!, withName: "unboxingVideo", fileName: "file2.mp4", mimeType: "unboxingVideo/mp4")
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


//                    let dicResponse: AnyObject? = dictionary.object(forKey: "UserInfo") as AnyObject
//                    let imgUser = dicResponse?.object(forKey: "Profile_Image") as? String
//                    UserDefaults.standard.setValue(imgUser, forKey: "Defaultsprofile_Image")

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
                print(Error.self)
                print("failure")

                break

            }


        })

    }
}



//MARK:- UploadUnboxingVideo API
extension TransctionOrderDetailsVC {
    func UploadUnboxingVideo(){

       let uplaodVideoParam = addUnboxingVideoRequest(orderRef: "", buyerRef: "", unboxingVideo: "")

        BuyerAPIManager.shareInstance.callingAddUnboxingVideo_API(addUnboxingVideoParam: uplaodVideoParam) { (result) in


            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()


                let status = (json as! addUnboxingVideoResponse).status
                print("msg: ",(json as! addUnboxingVideoResponse).msg!)
//                if status == "success" {
//                    print("msg: ",(json as! cancelOrderModelResponse).msg)
//                    self.navigationController?.popViewController(animated: true)
//                }
                print(status!)

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }


    }
}
