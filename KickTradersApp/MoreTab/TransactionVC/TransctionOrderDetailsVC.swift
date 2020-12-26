//
//  TransctionOrderDetailsVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 08/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

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
    
    @IBOutlet var btnUnboxingVideo: UIButton!
    @IBOutlet var btnCancelOrder: UIButton!
    @IBOutlet var btnTrackOrder: UIButton!
    @IBOutlet var btnAddRating: UIButton!
    
    @IBOutlet var lblOrderStatus: UILabel!
    @IBOutlet var imgShoes: UIImageView!
    @IBOutlet var lblShoeBrandName: UILabel!
    @IBOutlet var lblShoeName: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(strOrderNumber!)
       
        btnUnboxingVideo.isHidden = true
        btnAddRating.isHidden = true
        btnCancelOrder.isHidden = true
        btnTrackOrder.isHidden = true
        ShowOrderDetails()

      
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
    }
    
    
    @IBAction func actionCancelOrder(_ sender: Any) {
        ProgressHUD.show("Please wait.",  interaction: false)
        DispatchQueue.main.async {
            self.cancelOrderAPI()
        }
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
            lblOrderStatus.text = strOrderStatus
            lblOrderStatus.textColor = UIColor.systemYellow
            btnCancelOrder.isHidden = false
            btnTrackOrder.isHidden = false
        }
        
        else if strOrderStatus == "cancelled"{
            print("cancelled")
            lblOrderStatus.text = strOrderStatus
            lblOrderStatus.textColor = UIColor.systemRed
        }
        else {
            print("Delivered")
            lblOrderStatus.text = strOrderStatus
            lblOrderStatus.textColor = UIColor.systemGreen
            
            btnUnboxingVideo.isHidden = false
            btnAddRating.isHidden = false
            btnTrackOrder.isHidden = false
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
