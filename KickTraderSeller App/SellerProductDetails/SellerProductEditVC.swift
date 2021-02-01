//
//  SellerProductEditVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

var arrSellerProductColor = [SellerCOlors]()
var arrSellerShoeSize = [SellerSIze]()
class SellerProductEditVC: UIViewController {
    
    @IBOutlet var productImgSlider : PhotoSliderView!
    @IBOutlet var objScroll: UIScrollView!
    @IBOutlet var objTbl: UITableView!
    var getProductRef:String!
    var arrSellerimgShoe = [SellerImage]()

  //  var resPonseProductInfo: Any!



    @IBOutlet var lblProductBrandName: UITextField!
    @IBOutlet var lblProductName: UITextField!
    @IBOutlet var lblProductPrice: UITextField!



    @IBOutlet var lblAuthenticationOfProduct: UITextView!
    @IBOutlet var lblProductIsVerified: UITextField!



    @IBOutlet var lblProductDescription: UITextView!




    @IBOutlet var imgSellerProfile: UIImageView!
    @IBOutlet var lblSellerFullName: UILabel!
    @IBOutlet var lblSellerDescription: UILabel!
    @IBOutlet var lblSellerRating: FloatRatingView!
    




    @IBOutlet var lblStoreName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        NotificationCenter.default.addObserver(self, selector: #selector(NotificatonCallToUpdateImageOfShoe), name: Notification.Name(rawValue: "checkSize"), object: nil)
    objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height:1200))
        objTbl.tableFooterView = UIView()
        self.SellerProductDetailAPI()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
//           let images: [UIImage] = [UIImage(named: "Shoe")!,
//                                    UIImage(named: "shoe2")!,
//                                    UIImage(named: "ezgif1 1")!,
//                                    UIImage(named: "Shoe")!,
//                                    UIImage(named: "shoe2")!,
//                                    UIImage(named: "ezgif1 1")!]
//
//           productImgSlider.configure(with: images)
       }
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


    @objc func NotificatonCallToUpdateImageOfShoe()
    {
        productImgSlider.configure(with: UserDefaults.standard.value(forKey:"imgPass") as! [Any])

    }

}


//TODO:- Product Details API
extension SellerProductEditVC{
    func SellerProductDetailAPI(){


       // print("product Ref is: ",defaultss.string(forKey: "DefaultsproductRef")!)
        let SellerproductDetailParam = SelelrGetProductDetailsRequest(productRef: getProductRef, buyerRef:UserDefaults.standard.value(forKey:"DefaultssellerRef") as! String)
        APIManger.shareInstance.callingSellerProductDetail_API(sellerProductDetailParam:SellerproductDetailParam) {  (result) in




            switch result {
            case.success(let json):
                let resPonseProductInfo = (json as! SelelrGetProductDetailsResponse).productInfo
                print(resPonseProductInfo!)

               arrSellerProductColor = ((json as! SelelrGetProductDetailsResponse).productInfo?.colors)!


                //TODO:- Show Slider Images On Product Detail
                self.arrSellerimgShoe = arrSellerProductColor[0].image!
                shoeImgs =  self.arrSellerimgShoe.map({$0.imageName!})
                self.productImgSlider.configure(with: shoeImgs)


                //TODO:- Get size of all shoes
                arrSellerShoeSize = arrSellerProductColor[0].size!



                self.lblProductBrandName.text = resPonseProductInfo?.brandName
                self.lblProductName.text = resPonseProductInfo?.productName
                self.lblProductPrice.text = "\("$") \(resPonseProductInfo?.productPrice ?? "0.00")"
                self.lblAuthenticationOfProduct.text = resPonseProductInfo?.productDescription


                //TODO:- Product Authentication check here and do App logic accordingly
                let productIsVerified = Int((resPonseProductInfo?.authCount)!)
                if productIsVerified! >= 7 {
                   // imgProductVerfied.image = UIImage(systemName: "checkmark.circle.fill")
                    self.lblProductIsVerified.text = "Verified"

                }
                else {

                    self.lblProductIsVerified.text = "Not Verified"
                    self.lblProductIsVerified.textColor = UIColor.red
                }

                self.lblProductDescription.text = resPonseProductInfo?.productDescription



                //TODO:- Seller Description
                let img = resPonseProductInfo?.sellerDetail?.profile_Image
                print(img!)
                let imgProfileURL =  URL(string:"\(PROFILE_IMAGE)\(img!)")
                self.imgSellerProfile.kf.setImage(with:imgProfileURL!)
                self.lblSellerFullName.text = resPonseProductInfo?.sellerDetail?.full_Name
                self.lblSellerDescription.text = resPonseProductInfo?.sellerDetail?.shop_description
                self.lblSellerRating.rating = Double(Float((resPonseProductInfo?.sellerDetail?.avgRating!)!)!)

                DispatchQueue.main.async {
                    self.objTbl.reloadData()
                }


            case.failure(let err):
                print(err.localizedDescription)
                ProgressHUD.dismiss()
            }
        }
    }

}



//TODO:- TableView Datasource & Delegate
extension SellerProductEditVC: UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if indexPath.section == 0 {
            let sellerShoeSizeCell = tableView.dequeueReusableCell(withIdentifier: "SellerProductSizeCell", for: indexPath) as! SellerProductSizeCell

            sellerShoeSizeCell.reloadSellerProductSizeCC()

            return sellerShoeSizeCell
        }
        if indexPath.section == 1 {

            let sellerShoeColorCell = tableView.dequeueReusableCell(withIdentifier: "SellerProductColorCell", for: indexPath) as! SellerProductColorCell
            sellerShoeColorCell.reloadSellerProductColorCC()


            return sellerShoeColorCell

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

