//
//  sellerAddColorVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 09/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

var arrAddsize = [Size]()
var arrAddcolor = [Color]()

class sellerAddColorVC: UIViewController {
    
    
    @IBOutlet var objImgCollection: UICollectionView!
    @IBOutlet var objTable: UITableView!
    @IBOutlet var imgProductCover: UIImageView!
    
    var newImage : UIImage?
    var images: [UIImage] = []
    
    var imagePicker = UIImagePickerController()
    var defaultsColorAddProduct = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CallingGetAllDropDownBuyerAPI()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionAddimages(_ sender: Any) {
        self.OpenCameraMenu()
    }
    
    @IBAction func actionSubmitProduct(_ sender: Any) {
        self.CallingAddColorProductAPI()
    }
    
}


extension sellerAddColorVC {
    func CallingGetAllDropDownBuyerAPI(){
        
        ProgressHUD.show()
        APIManger.shareInstance.callingGetAllDropdownListAPI() {(result) in
            
            switch result{
            case.success(let json):
            print(json!)
                
            ProgressHUD.dismiss()
                arrCategories = ((json as! Welcome).array?.categories!)!
            
                
            arrbrands = ((json as! Welcome).array?.brands!)!
               // print("Brands are: ",arrbrands)
            
            
            arrAddcolor = ((json as! Welcome).array?.color!)!
                
             arrAddsize = ((json as! Welcome).array?.size!)!
      
                self.objTable.reloadData()
                
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}


//TODO:- TableView Datasource & Delegate
extension sellerAddColorVC: UITableViewDataSource, UITableViewDelegate{
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let SizeCell = tableView.dequeueReusableCell(withIdentifier: "SellerAddSizeTableCell", for: indexPath) as! SellerAddSizeTableCell
            SizeCell.reloadSellerAddSize()
            
            return SizeCell
        }
        if indexPath.section == 1 {
            
            let ColroCell = tableView.dequeueReusableCell(withIdentifier: "SellerAddColorTableCell", for: indexPath) as! SellerAddColorTableCell
            ColroCell.reloadSellerAddColor()
            
            return ColroCell
            
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
             return 100
        }
        else if indexPath.section  == 1{
             return 150
        }
        

        
       return 0
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        let Color = UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        
        if section == 0 {
            label.text = "   Select Shoe Size"
            label.textColor = Color
            label.font = label.font.withSize(15)
        } //else if section  == 1 {
//            label.text = "Colors: "
//            label.textColor = Color
//            label.font = label.font.withSize(15)
//        }
        else
            {
            label.text = "   Select Shoe Color"
            label.textColor = Color
            label.font = label.font.withSize(15)
        }
        
        return label
        
    }
    
}




//extension sellerAddColorVC {
//    func CallingAddColorProductAPI(){
//
//        ProgressHUD.show()
//
//        let colorProductParam = SellerAddColorProductModel(productRef: defaultsColorAddProduct.value(forKey: "DefaultsproductRef") as! String, colorRef: defaultsColorAddProduct.value(forKey: "DefaultsAddColorRef") as! String, sizeList: defaultsColorAddProduct.value(forKey: "DefaultsSelectedSize") as! [String], imageList: [])
//        APIManger.shareInstance.callingSellerAddColorProductAPI(sellerAddColorProductParam: colorProductParam) {(result) in
//
//            switch result{
//            case.success(let json):
//            print(json!)
//
//            ProgressHUD.dismiss()
//
//                let msg = (json as! SellerAddColorProductModelResponse).msg
//                print(msg)
//
//
//            case.failure(let err):
//                print(err.localizedDescription)
//            }
//
//        }
//
//    }
//}
//



extension sellerAddColorVC {
    
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
              
              action1.setValue(UIColor.purple, forKey: "titleTextColor")
              action2.setValue(UIColor.green, forKey: "titleTextColor")
            
              alertController.addAction(action1)
              alertController.addAction(action2)
              alertController.addAction(maybeAction)
              
              self.present(alertController, animated: true, completion: nil)
              
    }

}


//MARK:- UIImagePicker Methods
extension sellerAddColorVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
            
            images.append(selectedImg)
            print(images)
            //save image ?? Display Image
          // imgProductCover.image = selectedImg

        }
        self.dismiss(animated: true, completion: nil)
        self.objImgCollection.reloadData()
    }
    
 
}



//TODO:- Update User Info API
extension sellerAddColorVC{
    func CallingAddColorProductAPI(){

        ProgressHUD.show("Updating.", interaction: false)
        //Set Your URL
        let api_url = SellerAddProduectColor_url
        guard let url = URL(string: api_url) else {
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")


        //Set Your Parameter
        let parameterDict = NSMutableDictionary()
        parameterDict.setValue(defaultsColorAddProduct.value(forKey: "DefaultsproductRef") as! String, forKey: "productRef")
        parameterDict.setValue(defaultsColorAddProduct.value(forKey: "DefaultsAddColorRef") as! String, forKey: "colorRef")
            
        
        
        print("Check",(defaultsColorAddProduct.value(forKey: "DefaultsSelectedSize") as! String, forKey: "sizeList"))
        
        
        parameterDict.setValue(defaultsColorAddProduct.value(forKey: "DefaultsSelectedSize") as! String, forKey: "sizeList")
        parameterDict.setValue("1", forKey: "imageCount")


      //parameterDict.setValue(selectedImage!, forKey: "image")

        print(parameterDict)
        //Set Image Data
        
        let imgData = images[0].jpegData(compressionQuality: 0.75)

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
            
            multiPart.append(imgData!, withName: "imageList1", fileName: "image1.png", mimeType: "image/png")
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


extension sellerAddColorVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ImgCollection =  collectionView.dequeueReusableCell(withReuseIdentifier: "sellerAddImageCollection", for: indexPath) as! sellerAddImageCollection
        ImgCollection.imgAddProductCover.image = images[indexPath.row]
        
      // let sizeDataModel = arrAddcolor[indexPath.row]
//        SizeCollection.lblColor.backgroundColor = UIColor(hexFromString:sizeDataModel.colorCode!)
        
        return ImgCollection
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!SellerAddColorCollectionCell
//
//        let defaultsAddColor = UserDefaults.standard
//        defaultsAddColor.setValue(arrAddcolor[indexPath.row].colorRef, forKey: "DefaultsAddColorRef")
//
//        CCell.isSelected = true
//        CCell.layer.cornerRadius = CCell.bounds.height/2
//        CCell.layer.backgroundColor = UIColor.black.cgColor
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
//        let CCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath) as!SellerAddColorCollectionCell
//        CCell.layer.backgroundColor = UIColor.clear.cgColor
//
//    }
//
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              return CGSize(width: 100 , height: 100)
          }

          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
              return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
          }

    
    
}

