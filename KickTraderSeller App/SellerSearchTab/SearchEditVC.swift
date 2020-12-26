//
//  SearchEditVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 09/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class SearchEditVC: UIViewController {
    
    
    @IBOutlet weak var objTable: UITableView!
    @IBOutlet var lblHeaderProductName: UILabel!
    
    var arrProductColor = [COlors]()
    var arrSize = [SIze]()
    var arrimgShoe = [Image]()
    var strProductRef:String!
    var strcolorRef: String!
    var strTest: String!
    
    
    
    var productCoverImage: String!
    
    var productName: String!
    
   // var productName: String!
    
    var productSubCategory: String!
    
    var productPrice: String!
    
    var brandName: String!
    
    var productDescription: String!
    
  //  var productName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productDetailAPI()
        
        strTest = "0"

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.productDetailAPI()
        
        strTest = "0"

    }
    
    
    
    
    @IBAction func actionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionEditProduct(_ sender: Any) {
        let vcEditProduct =  self.storyboard?.instantiateViewController(identifier: "sellerEditProduct")as! sellerEditProduct
        
        vcEditProduct.strShoeImg = productCoverImage
        vcEditProduct.strShoeName = productName
        vcEditProduct.strGender = productSubCategory
        vcEditProduct.strShoePrice = productPrice
        vcEditProduct.strShoeBrand = brandName
        vcEditProduct.strShoedesc = productDescription
        
        
        self.navigationController?.pushViewController(vcEditProduct, animated: true)
    }
    
    
    
    @IBAction func actionAddColor(_ sender: Any) {
        
        let vcAddColor =  self.storyboard?.instantiateViewController(identifier: "sellerAddColorVC") as! sellerAddColorVC
        self.navigationController?.pushViewController(vcAddColor, animated: true)
    }
    
}



//TODO:- Product Details API
extension SearchEditVC{
    func productDetailAPI(){
        
        
       
        let productDetailParam = BuyerGetProductDetailsModel(productRef:strProductRef)
        BuyerAPIManager.shareInstance.callingBuyergetProductDetailAPI(buyerProductDetails: productDetailParam) { [self] (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                
                
                let resPonseProduct = (json as! BuyerGetProductDetailsModelResponse).productInfo!
                print(resPonseProduct)
                
                arrProductColor = ((json as! BuyerGetProductDetailsModelResponse).productInfo?.colors)!
                arrSize = arrProductColor[0].size!
                let arr0 = arrProductColor[0].size
                print(arr0!)
                self.arrimgShoe = arrProductColor[0].image!
                
                
                
                productCoverImage = resPonseProduct.productCoverImage
                productName =  resPonseProduct.productName
                productSubCategory =  resPonseProduct.productSubCategory
                productPrice =  resPonseProduct.productPrice
                brandName =  resPonseProduct.brandName
                productDescription =  resPonseProduct.productDescription
                lblHeaderProductName.text = resPonseProduct.productName?.capitalized
                
                

                //TODO:- Update the Table View
                self.objTable.reloadData()
               
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}



extension SearchEditVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductColor.count
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SearchEditCell", for: indexPath) as! SearchEditCell
        
        
        
        let SearchShowData = arrProductColor[indexPath.row]
        
        
        
        //        let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(String(describing: SearchShowDataImg![0].imageName))")
        //        cell.imgShoes?.kf.setImage(with: imgURL)
        
        
        let SearchShowSizeData = arrProductColor[indexPath.row].size
        
        //TODO:- To get Size in string
        for i in (0..<arrProductColor[indexPath.row].size!.count)
        {
            if strTest == "" || strTest == "0"{
                strTest = "\(String(describing: SearchShowSizeData![i].sizeName!))"
            }
            
            else {
                strTest = "\(String(describing: strTest!)) , \(String(describing: SearchShowSizeData![i].sizeName!))"
                
            }
            cell.lblproductSize.text = strTest
            
        }
        strTest = "0"
        
    
        let SearchShowSizeDataIMg = arrProductColor[indexPath.row].image
        let imgName = SearchShowSizeDataIMg![0].imageName!
        
        let imgURL =  URL(string:"\(PRODUCT_IMAGE)\(imgName)")
        cell.imgShoes?.kf.setImage(with: imgURL)
        cell.lblproductColor.backgroundColor = UIColor(hexFromString:SearchShowData.colorCode!)
        
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit .addTarget(self, action: #selector(btnEditClicked), for:.touchUpInside)
        
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete .addTarget(self, action: #selector(btnDeleteClicked), for:.touchUpInside)
        
        
        return cell
        
    }
        
        
    }
    

//MARK:- Button Edit Item Clicked
extension SearchEditVC{
    @objc func btnEditClicked(sender: UIButton){
    
//        let vcEditSearch = self.storyboard?.instantiateViewController(identifier: "SearchEditVC") as! SearchEditVC
//        self.navigationController?.pushViewController(vcEditSearch, animated: true)
//
    }
}


//MARK:- Button Delete Item Clicked
extension SearchEditVC{
    @objc func btnDeleteClicked(sender: UIButton){
        
        strcolorRef = arrProductColor[sender.tag].colorRef
        
        DispatchQueue.main.async {
            ProgressHUD.show("Removing Color.",  interaction: false)
            self.removeColorAPI()
        }
        
    
    
    }
}

//TODO:- Product Details API
extension SearchEditVC{
    func removeColorAPI(){
        
        
       
        let removeColorParam = SellerRemoveColorModel(productRef: strProductRef, colorRef: strcolorRef)
        APIManger.shareInstance.callingRemoveColorAPI(SellerRemoveColorParam:removeColorParam) {  (result) in
            
            
            ProgressHUD.dismiss()
            switch result {
            case.success(let json):
                
                print(json!)
                let resPonseProduct = (json as! SellerRemoveColorModelResponse).msg
                print(resPonseProduct)
                
               
                //TODO:- Update the Table View
                self.productDetailAPI()
               
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
