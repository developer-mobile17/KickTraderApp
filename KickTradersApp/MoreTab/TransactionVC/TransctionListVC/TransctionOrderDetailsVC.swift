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

class AppSnackBar: SnackBar {

    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .black
        style.textColor = .white
        return style
    }
}

class TransctionOrderDetailsVC: UIViewController {
    
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
    
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        print(strOrderNumber!)
        print(strProductRef!)

       
        btnUnboxingVideo.isHidden = true
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
    }
    
    @IBAction func actionRating(_ sender: Any) {
        
        let vcRating = self.storyboard?.instantiateViewController(identifier: "RateSellerVC") as! RateSellerVC
        self.navigationController?.pushViewController(vcRating, animated: true)
        
        
    }
    
    @IBAction func actionTrackOrder(_ sender: Any) {


//        AppSnackBar.make(in: self.view, message: "The Internet connection appears to be offline.", duration: .lengthShort).setAction(with: "Done", action: {
//
//        }).show()
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
        let imgProduct =  URL(string:"\(PRODUCT_COVER_IMAGE)\(strproductCoverImage!)")
        self.imgShoes.kf.setImage(with:imgProduct!)
        lblShoeBrandName.text = strbrandName
        lblShoeName.text = strproductName
        lblSize.text = strSize
        lblPrice.text = "\("Bid Price:$") \(String(describing: strbidPrice!))"
        lblColor.backgroundColor = UIColor(hexFromString:strcolorCode)
        
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
