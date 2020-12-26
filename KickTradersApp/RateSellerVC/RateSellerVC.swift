//
//  RateSellerVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 31/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import Kingfisher

class RateSellerVC: UIViewController,UITextViewDelegate {
    
    
    @IBOutlet var imgSeller: UIImageView!
    @IBOutlet var lblSellerName: UILabel!
    @IBOutlet var lblSellerDescription: UILabel!
    @IBOutlet var txvSellerComment: UITextView!
    @IBOutlet var objSellerRating: FloatRatingView!
    
    
    
    
    @IBOutlet var imgBuyer: UIImageView!
    @IBOutlet var lblBrandName: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblBidPrice: UILabel!
    @IBOutlet var lblProductColor: UILabel!
    @IBOutlet var txvBuyerComment: UITextView!
    @IBOutlet var objProductRating: FloatRatingView!
    
    
    
    
    
    var strSellerRating: String!
    var strProductRating: String!
    var defaultsRate = UserDefaults.standard
    var StrFromRefUser: String!
    var strProductRef : String!
    
    
    
    //TODO: Seller Data
    var strSellerRef : String!
    var strSellerFullName : String!
    var strSellerProfileImg : String!
    var strSellerShopDesc : String!
    
    
    
    //TODO: Buyer/Product Data
    var strproductName : String!
    var strbrandName : String!
    var strproductCoverImage : String!
    var strcolorCode : String!
    var strbidPrice : String!
    
    
   
    var checkRatingToWhom:String!
    var toRef : String!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        print(defaultsRate.value(forKey: "DefaultsSellerRef")!)
        
        strSellerRef = (defaultsRate.value(forKey:"DefaultsSellerRef") as! String)
        strProductRef = (defaultsRate.value(forKey:"DefaultsProductRef") as! String)
        

        // Show Data of Seller
        strSellerProfileImg = (defaultsRate.value(forKey:"DefaultsSellerProfile_Image") as! String)
        lblSellerName.text = (defaultsRate.value(forKey: "DefaultsSellerFull_Name") as! String)
        lblSellerDescription.text = (defaultsRate.value(forKey: "DefaultsSellershop_description") as! String)
        let imgSellerProfileURL =  URL(string:"\(PROFILE_IMAGE)\(strSellerProfileImg!)")
        self.imgSeller.kf.setImage(with:imgSellerProfileURL!)
        
        
        
        
        
        // Show Product info
        
        strproductCoverImage = (defaultsRate.value(forKey:"DefaultsproductCoverImage") as! String)
        let imgProduct =  URL(string:"\(PRODUCT_COVER_IMAGE)\(strproductCoverImage!)")
        self.imgBuyer.kf.setImage(with:imgProduct!)
        
        lblBrandName.text = (defaultsRate.value(forKey:"DefaultsbrandName") as! String)
        
        lblProductName.text = (defaultsRate.value(forKey:"DefaultsproductName") as! String)
        
        strbidPrice = (defaultsRate.value(forKey:"DefaultsbidPrice") as! String)
        lblBidPrice.text = "\("Bid Price:$")\(String(describing: strbidPrice!))"
        
        strcolorCode = (defaultsRate.value(forKey:"DefaultscolorCode") as! String)
        lblProductColor.backgroundColor = UIColor(hexFromString:strcolorCode)
        
        
        txvSellerComment.delegate = self
        txvSellerComment.text = "Placeholder text goes right here..."
        txvSellerComment.textColor = UIColor.lightGray
        
        
        
        txvBuyerComment.delegate = self
        txvBuyerComment.text = "Placeholder text goes right here..."
        txvBuyerComment.textColor = UIColor.lightGray
        
        
        objSellerRating.delegate  = self
        objProductRating.delegate = self
        objSellerRating.type = .halfRatings
        objProductRating.type = .halfRatings
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txvSellerComment.textColor == UIColor.lightGray {
            txvSellerComment.text = ""
            txvSellerComment.textColor = UIColor.black
        }
        
        
        if txvBuyerComment.textColor == UIColor.lightGray {
            txvBuyerComment.text = ""
            txvBuyerComment.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txvSellerComment.text == "" {
            
            txvSellerComment.text = "Placeholder text ..."
            txvSellerComment.textColor = UIColor.lightGray
        }
        
        
        
        if txvBuyerComment.text == "" {
            
            txvBuyerComment.text = "Placeholder text ..."
            txvBuyerComment.textColor = UIColor.lightGray
        }
    }
    
    
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
         
      }

    
    @IBAction func actionRateSeller(_ sender: Any) {
        
        checkRatingToWhom = "sellerRating"
        
        ProgressHUD.show("Please wait.",  interaction: false)
        DispatchQueue.main.async {
            self.callingaddReviewAPI()
        }
    }
    
    
    @IBAction func actionRateBuyer(_ sender: Any) {
        checkRatingToWhom = "buyerRating"
        ProgressHUD.show("Please wait.",  interaction: false)
        DispatchQueue.main.async {
            self.callingaddReviewAPI()
        }
        
      }
    
 }


//TODO:- get Buyer Orders  API
extension RateSellerVC {
    func callingaddReviewAPI() {
        
        
        if checkRatingToWhom == "sellerRating" {
            // Seller Selected
            toRef = strSellerRef
            
        }
        else {
            toRef = strProductRef
        }
        
        StrFromRefUser = defaultsRate.value(forKey: "DefaultsbuyerRef") as? String
        
        let addReviewParam = addReviewModel(fromRef: StrFromRefUser, toRef: toRef, rating: "4", comment: txvSellerComment.text)
        
        BuyerAPIManager.shareInstance.addReviewAPI(addReviewParam: addReviewParam) { (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                
                let msg = (json as! addReviewModelResponse).msg
                print(msg)
                
            
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
  
}



extension RateSellerVC:FloatRatingViewDelegate {

    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
       
        strSellerRating = String(format: "%2f", self.objSellerRating.rating)
        print(" Seller Rating is: ",strSellerRating!)
        
        
        strProductRating = String(format: "%2f", self.objProductRating.rating)
        print("Product Rating is: ",strProductRating!)
    }
    
}





