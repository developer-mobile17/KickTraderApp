//
//  ProductDetailVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 26/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

var arrProductColor = [COlors]()
var arrSize = [SIze]()
var arrImg = [Image]()
var shoeImgs:[String] = []


class ProductDetailVC: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet var productImgSlider : PhotoSliderView!
    @IBOutlet var objScroll: UIScrollView!
    @IBOutlet var objTable: UITableView!
    @IBOutlet var tblUserReview: UITableView!
    
    
    
    //TODO:- Product info Outlet
    @IBOutlet var productName: UILabel!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var btnPlayVideo: UIButton!
    
    
    @IBOutlet var sellerName: UILabel!
    @IBOutlet var sellerPostingDate: UILabel!
    @IBOutlet var imgSellerProfile:UIImageView!
    //@IBOutlet var productPrice: UILabel!
    
    
    @IBOutlet var productStatus: UILabel!
    @IBOutlet var sellerProductDescription: UILabel!
    @IBOutlet var lblNoReviewsYet: UILabel!
    


    //TODO:- Seller Total Rating & Review Count
    @IBOutlet var sellerTotalAvgRating: UILabel!
    @IBOutlet var sellerTotalReviewCount: UILabel!
    @IBOutlet var objSellerRating: FloatRatingView!

    var arrComment = [Comments]()
    var arrimgShoe = [Image]()
    var strProductPrice : String?
    var strPlaceABidPrice : String?
    var bidPriceTextField: UITextField?
    
    
    var arrPassSliderImg = [String]()
    var defaultss = UserDefaults.standard
    

    var productVideo: String!
    
    // var arrSellerDetails = [SellerDetail]()
    
    
    
    
    
    //TODO:- ViewDid Load
    override func viewDidLoad() {
        super.viewDidLoad()


        lblNoReviewsYet.text = "There are no reviews yet.\n Only logged in customers who have purchased this product may leave a review."
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishDownloading), name: Notification.Name(rawValue: "check"), object: nil)
        objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height: 1700))
        self.productDetailAPI()
        
        

        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
}




//TODO:- UIButton Action
extension ProductDetailVC{
    
    
    @IBAction func actionPlayVideo(_ sender: Any) {

        let productVidVC = self.storyboard?.instantiateViewController(identifier: "ProductVideoVC") as! ProductVideoVC
        productVidVC.productVideoPass = productVideo
        productVidVC.productNamePass =  self.productName.text 
        
        self.navigationController?.pushViewController(productVidVC, animated: true)
        
    }
    
    @IBAction func actionPlaceBid(_ sender: Any) {
        self.PlaceBidalertWithTF()
        
    }
    
    @IBAction func actionAddtoCard(_ sender: Any) {
        self.callingAddToCartAPI()
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didFinishDownloading()
    {


        productImgSlider.configure(with: UserDefaults.standard.value(forKey: "imgPass") as! [Any])

    }
}


//TODO:- Product Details API
extension ProductDetailVC{
    func productDetailAPI(){
        
        
        print("product Ref is: ",defaultss.string(forKey: "DefaultsproductRef")!)
        let productDetailParam = BuyerGetProductDetailsModel(productRef:defaultss.string(forKey: "DefaultsproductRef")!)
        BuyerAPIManager.shareInstance.callingBuyergetProductDetailAPI(buyerProductDetails: productDetailParam) { [self] (result) in
            
            
            switch result {
            case.success(let json):
                let resPonseProduct = (json as! BuyerGetProductDetailsModelResponse).productInfo!
                arrProductColor = ((json as! BuyerGetProductDetailsModelResponse).productInfo?.colors)!
                arrSize = arrProductColor[0].size!
                arrComment = resPonseProduct.comments!
                self.tblUserReview.reloadData()
                
                
                //TODO:- Show Slider Images On Product Detail
                
                self.arrimgShoe = arrProductColor[0].image!
                shoeImgs =  self.arrimgShoe.map({$0.imageName!})
                productImgSlider.configure(with: shoeImgs)
                
                
                
                
                //TODO:- Update the Table View
                self.objTable.reloadData()
                
                
                
                //TODO:- Get ProductVideo and Pass to ProductVideoVC
                productVideo = resPonseProduct.productVideo

                
                //TODO:- Pass ProductVideo array to ProductVideoVC
                let productVideoPass = ((json as! BuyerGetProductDetailsModelResponse).productInfo?.unboxingVideos)!

                if productVideo .isEmpty && productVideoPass.count == 0 {
                    btnPlayVideo.isHidden = true
                }




                if let data = try? PropertyListEncoder().encode(productVideoPass) {
                    
                    UserDefaults.standard.set(data, forKey: "DefaultsproductVideoPass")
                    
                }
                
                
                //TODO:- Update the Product Info
                self.productName.text = resPonseProduct.productName
                self.productDescription.text = resPonseProduct.productDescription
                self.productPrice.text! =   "\("$")\(resPonseProduct.productPrice!)"
                self.defaultss.setValue(resPonseProduct.productRef, forKey:"DefaultsproductRef")

                //TODO:- Update the Seller Description Info

                let img = (json as! BuyerGetProductDetailsModelResponse).productInfo?.sellerDetail?.profile_Image!
                print(img!)
                let imgProfileURL =  URL(string:"\(PROFILE_IMAGE)\(img!)")

                self.imgSellerProfile.kf.setImage(with:imgProfileURL!)

                objSellerRating.rating = Double(Float((resPonseProduct.sellerDetail?.avgRating!)!)!)
                print(resPonseProduct.sellerDetail?.profile_Image as Any)

                self.sellerName.text = resPonseProduct.sellerDetail?.full_Name
                self.sellerPostingDate.text = resPonseProduct.sellerDetail?.shop_description
                self.sellerProductDescription.text = resPonseProduct.productDescription
                self.sellerTotalReviewCount.text =
                    "( \(String(arrComment.count)) \( "Review") )"



                if arrComment.count == 0 {
                    self.sellerTotalAvgRating.text = "0"
                    lblNoReviewsYet.isHidden = false
                }
                else {

                    lblNoReviewsYet.isHidden = true
                    let floatCommentCOunt = Float(arrComment.count)
                    let ratingMap = arrComment.map({$0.rating})
                    let ratingConvertToINT = ratingMap.map {Float($0!)!}
                    let addtionIS = ratingConvertToINT.reduce(0,+)
                    let finalRating = addtionIS / floatCommentCOunt
                    self.sellerTotalAvgRating.text = String(finalRating)

                }




            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}



//TODO:- TableView Datasource & Delegate
extension ProductDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // return 2

        if tableView == tblUserReview {
            return 1
        }
        else {
            return 2
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblUserReview {
            return arrComment.count
        }
        else {
            return 1
        }
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == tblUserReview{
            
            let userReview_cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailReviewCell", for: indexPath) as! ProductDetailReviewCell
            
            if arrComment.count == 0 {
                print("NO Data")

            }
            else {

                let imgURL = URL(string:"\(PROFILE_IMAGE)\(arrComment[indexPath.row].profile_Image!)")
                userReview_cell.imgCommentUser.kf.setImage(with: imgURL)

                userReview_cell.lblUsername.text = arrComment[indexPath.row].full_Name
                userReview_cell.lblReviewDate.text = arrComment[indexPath.row].create_at
                userReview_cell.lblReviewDesc.text = arrComment[indexPath.row].comment
                userReview_cell.lblReviewRating.text = arrComment[indexPath.row].rating
                
                return userReview_cell
            }
            
            
        }
        
        else if tableView == objTable {
            
            if indexPath.section == 0 {
                let SizeCell = tableView.dequeueReusableCell(withIdentifier: "ProductSizeCell", for: indexPath) as! ProductSizeCell
                SizeCell.reloadProductSizeCC()
                
                return SizeCell
            }
            if indexPath.section == 1 {
                
                let ColroCell = tableView.dequeueReusableCell(withIdentifier: "ProductColorCell", for: indexPath) as! ProductColorCell
                ColroCell.reloadProductColorCC()
                
                
                return ColroCell
                
            }
        }
        
        return UITableViewCell()
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == tblUserReview {
            
        }
        else {
            
            
            let label = UILabel()
            // let Color = UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            
            if section == 0 {
                label.text = "Size:"
                //  label.textColor = Color
                label.font = label.font.withSize(15)
            } else  {
                label.text = "Colors: "
                // label.textColor = Color
                label.font = label.font.withSize(15)
            }
            
            return label
            
        }
        return UILabel()
        
    }
    
    
    
}

//TODO:- Add to Cart API
extension ProductDetailVC {
    func callingAddToCartAPI() {

        guard let buyerRef = defaultss.string(forKey: "DefaultsbuyerRef") else {return}
        print(buyerRef)
        guard let productRef = defaultss.string(forKey: "DefaultsproductRef") else {return}
        print(productRef)
        guard let coloToProductRef = defaultss.string(forKey: "DefaultscoloToProductRef") else {
            return showAlert(alertMessage: "Please select shoe color")
        }
        print(coloToProductRef)
        guard let sizeToColorRef = defaultss.string(forKey: "DefaultssizeToColorRef") else {return showAlert(alertMessage: "Please select shoe size")}
        print(sizeToColorRef)
        
        
        ProgressHUD.show("Adding to cart...", interaction: false)
        
        let addToCartParma = addToCartModel(buyerRef: buyerRef, productRef: productRef, coloToProductRef: coloToProductRef, sizeToColorRef: sizeToColorRef)
        
        BuyerAPIManager.shareInstance.callingAddItemToCartAPI(addItemToCartParam: addToCartParma) {(result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                let msg = (json as! addToCartModelResponse).msg
                self.showAlert(alertMessage:msg)

                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
    
}





//TODO:- Place A Bid API
extension ProductDetailVC {
    func callingPlaceABidAPI() {
        

        
        guard let buyerRef = defaultss.string(forKey: "DefaultsbuyerRef") else {return}
        guard let productRef = defaultss.string(forKey: "DefaultsproductRef") else {return}
        guard let coloToProductRef = defaultss.string(forKey: "DefaultscoloToProductRef") else {return showAlert(alertMessage: "Please select shoe color") }
        guard let sizeToColorRef = defaultss.string(forKey: "DefaultssizeToColorRef") else {return showAlert(alertMessage: "Please select shoe size")}
        guard let bidPrice = self.bidPriceTextField?.text else {return showAlert(alertMessage: "Please enter bid price") }
        
        let placeABidParma = PlaceABidModel(productRef: productRef, coloToProductRef: coloToProductRef, sizeToColorRef: sizeToColorRef, buyerRef: buyerRef, bidPrice: bidPrice)
        
        ProgressHUD.show("Please wait.",  interaction: false)
        BuyerAPIManager.shareInstance.callingPlaceABidAPI(PlaceABidParam: placeABidParma) {(result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                let msg = (json as! PlaceABidModelResponse).msg
                self.showAlert(alertMessage:msg)
            //print(msg)

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
    
}
extension ProductDetailVC {
    func PlaceBidalertWithTF() {
        // 1.
        
        
        // 2.
        let alertController = UIAlertController(
            title: "KickTrader App",
            message: "Please enter your Bid Price",
            preferredStyle: .alert)
        
        // 3.
        let loginAction = UIAlertAction(
            title: "Submit", style: .default) {
            (action) -> Void in
            
            let bidPrice = self.bidPriceTextField?.text
            if  bidPrice == "" {
                print("No Bid Price entered")
                
            } else {
                print(" Bid Price = \(String(describing: bidPrice!))")
                self.callingPlaceABidAPI()
            }
            
            
            
        }
        
        // 4.
        alertController.addTextField {
            (txtUsername) -> Void in
            self.bidPriceTextField = txtUsername
            self.bidPriceTextField!.placeholder = "Enter Bid Price"
        }
        
        
        // 5.
        alertController.addAction(loginAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
}
