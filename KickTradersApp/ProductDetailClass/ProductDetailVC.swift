//
//  ProductDetailVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 26/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
//import SnapKit
//import SnackBar_swift



var arrProductColor = [COlors]()
var arrSize = [SIze]()
var arrImg = [Image]()
var shoeImgs:[String] = []


class ProductDetailVC: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet var productImgSlider : PhotoSliderView!
    @IBOutlet var objScroll: UIScrollView!
    @IBOutlet var objTable: UITableView!
    @IBOutlet var btnAddToCart: UIButton!
    @IBOutlet var btnPlaceBid: UIButton!
    @IBOutlet var objFooterView: UIView!
    
    
    
    //TODO:- Product info Outlet
    @IBOutlet var productName: UILabel!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var btnPlayVideo: UIButton!
    @IBOutlet var btnSetFavourite: UIButton!

    @IBOutlet var productVerifiedCheck: UILabel!
    @IBOutlet var imgProductVerfied: UIImageView!
    
    @IBOutlet var sellerName: UILabel!
    @IBOutlet var sellerPostingDate: UILabel!
    @IBOutlet var imgSellerProfile:UIImageView!
    //@IBOutlet var productPrice: UILabel!
    
    
    @IBOutlet var productStatus: UILabel!
    @IBOutlet var sellerProductDescription: UILabel!
    @IBOutlet var lblNoReviewsYet: UILabel!
    


    //TODO:- Seller Total Rating & Review Count

    @IBOutlet var imgWarning1: UIImageView!
    @IBOutlet var imgWarning2: UIImageView!
    @IBOutlet var imgWarning3: UIImageView!
    
    
    @IBOutlet var sellerTotalAvgRating: UILabel!
    @IBOutlet var sellerTotalReviewCount: UILabel!
    @IBOutlet var btnTotalReviewCount: UIButton!
    @IBOutlet var objSellerRating: FloatRatingView!

    var arrComment = [Comments]()
    var arrimgShoe = [Image]()
    var strProductPrice : String?
    var strPlaceABidPrice : String?
    var bidPriceTextField: UITextField?
    
    
    var arrPassSliderImg = [String]()
    var defaultss = UserDefaults.standard
    

    var productVideo: String!
    var checkFavoutite : String!
    var strActionFav: String?
    
    // var arrSellerDetails = [SellerDetail]()
    
    
    
    
    
    //TODO:- ViewDid Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        imgWarning1.isHidden = true
        imgWarning2.isHidden = true
        imgWarning3.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(didFinishDownloading), name: Notification.Name(rawValue: "check"), object: nil)

        objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height: 1700))


        DispatchQueue.main.async {
            ProgressHUD.show("Loading product info.",  interaction: false)
            self.productDetailAPI()

        }

        


        
        
    }

    @IBAction func actionTotalReviewSee(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CustomerReviewVC") as? CustomerReviewVC else{

            return
        }
        present(vc, animated: true)
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




    @IBAction func actionSetFav(_ sender: UIButton) {

        sender.isSelected.toggle()

        if sender.isSelected {
            print("selected")


            strActionFav = "1"
            self.addProductToFavourite()
        }
        else {
            print("Not selected")

            strActionFav = "0"
            self.addProductToFavourite()

        }


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
        let productDetailParam = BuyerGetProductDetailsModel(productRef:defaultss.string(forKey: "DefaultsproductRef")!,buyerRef: defaultss.value(forKey: "DefaultsbuyerRef") as! String)
        BuyerAPIManager.shareInstance.callingBuyergetProductDetailAPI(buyerProductDetails: productDetailParam) { [self] (result) in



            
            switch result {
            case.success(let json):
                let resPonseProduct = (json as! BuyerGetProductDetailsModelResponse).productInfo!
                arrProductColor = ((json as! BuyerGetProductDetailsModelResponse).productInfo?.colors)!
                arrSize = arrProductColor[0].size!
                arrComment = resPonseProduct.comments!

                //TODO:- Pass StructArray into UserDefaults

                let selectedArrPass = resPonseProduct.comments!
                if let data = try? PropertyListEncoder().encode(selectedArrPass) {

                    UserDefaults.standard.set(data, forKey: "arrCommentPass")

                }

                

                //TODO:- Check Product is Favourite or not!
                print(resPonseProduct.favorite!)

                if (resPonseProduct.favorite) == true {
                    btnSetFavourite.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)

                }
                else {
                    btnSetFavourite.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                }


                //TODO:- Show Slider Images On Product Detail
                
                self.arrimgShoe = arrProductColor[0].image!
                shoeImgs =  self.arrimgShoe.map({$0.imageName!})
                productImgSlider.configure(with: shoeImgs)
                
                

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


                //TODO:- Product Authentication check here and do App logic accordingly
                let productIsVerified = Int((resPonseProduct.authCount)!)
                if productIsVerified! >= 7 {
                    imgProductVerfied.image = UIImage(systemName: "checkmark.circle.fill")
                    productVerifiedCheck.text = "Verified"

                }
                else {
                    
                    productVerifiedCheck.text = "Not Verified"
                    productVerifiedCheck.textColor = UIColor.red
                }



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


                if arrComment.count == 0 {
                    btnTotalReviewCount.setTitle("( \(String(arrComment.count)) \("Review.") )", for: .normal)
                    btnTotalReviewCount.isUserInteractionEnabled = false

                }

                else {
                    btnTotalReviewCount.setTitle("( \(String(arrComment.count)) \( "Review, Tap to see all.") )", for: .normal)

                }


                //TODO:- Seller Dispute Count here and do App logic accordingly
                let disputeCount = Int((resPonseProduct.sellerDetail?.disputeCount)!)
                if disputeCount == 3 {
                    imgWarning1.isHidden = false

                }
                if disputeCount! >= 6 || disputeCount! <= 9 {
                    imgWarning1.isHidden = false
                    imgWarning2.isHidden = false

                }

                else {

                }

                if arrComment.count == 0 {
                    self.sellerTotalAvgRating.text = "0"

                }
                else {

                    //  lblNoReviewsYet.isHidden = true
                    let floatCommentCOunt = Float(arrComment.count)
                    let ratingMap = arrComment.map({$0.rating})
                    let ratingConvertToINT = ratingMap.map {Float($0!)!}
                    let addtionIS = ratingConvertToINT.reduce(0,+)
                    let finalRating = addtionIS / floatCommentCOunt
                    self.sellerTotalAvgRating.text = String(finalRating)

                }


                //TODO:- Update the Table View
                self.objTable.reloadData()
                ProgressHUD.dismiss()



            case.failure(let err):
                print(err.localizedDescription)
                ProgressHUD.dismiss()
            }
        }
    }
}



//TODO:- TableView Datasource & Delegate
extension ProductDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


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

        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

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



extension ProductDetailVC {
    func addProductToFavourite(){

        ProgressHUD.show(interaction: false)

        let addFavouriteParma = addFavoriteModel(buyerRef:defaultss.value(forKey: "DefaultsbuyerRef") as! String , productRef:defaultss.string(forKey: "DefaultsproductRef")! ,action:strActionFav!)
        // print(addFavouriteParma)
        BuyerAPIManager.shareInstance.addFavoriteAPI(addFavoriteParam: addFavouriteParma) {(result) in

            switch result{
            case.success(let json):
                ProgressHUD.dismiss()
                print((json as! addFavoriteModelResponse).msg)

                AppSnackBar.make(in: self.view, message: ((json as! addFavoriteModelResponse).msg), duration: .lengthShort).show()

            case.failure(let err):
                print(err.localizedDescription)
            }

        }

    }
}


