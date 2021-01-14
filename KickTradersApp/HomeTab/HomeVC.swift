//
//  HomeVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import WMSegmentControl
import Kingfisher


class HomeVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    @IBOutlet var objTable: UITableView!
    @IBOutlet var imgProfile: UIImageView!
    
    var arrShoesBuyerProduct = [Shoes]()
    var arrSneakersBuyerProduct = [Sneakers]()
    var arrBootBuyerProduct = [Boot]()
    
    
    var filteredRecipes = [Shoes]()
    var strImgURL:String!
    var checkCategory: String?
    var productRef: String?
    var favID: String?
    var strActionFav: String?
    var defaultsHome = UserDefaults.standard
    
    @IBOutlet var lblPrice : UILabel!
    @IBOutlet var imgShoes : UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar?.delegate = self
        self.segmentLoadData()
        self.getProfileImg()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        checkCategory = "1"
        DispatchQueue.main.async {
            self.getBuyerProductList()
            self.objTable.reloadData()
        }

    }
    //TODO:-  Get the User Profile
    func getProfileImg (){

        strImgURL = defaultsHome.value(forKey: "Defaultsprofile_Image")! as? String
        if strImgURL == nil {
            print("No Profile Img")
        }
        else {
            let imgProfileURL =  URL(string: "\(PROFILE_IMAGE)\(strImgURL!)")
            self.imgProfile.kf.setImage(with:imgProfileURL)
        }
        

    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRecipes.removeAll()
        if let searchText = searchBar.text, !searchText.isEmpty {
            self.filteredRecipes = self.arrShoesBuyerProduct.filter { recipe in
                guard recipe.brandName != nil else { return false }
                return ((recipe.brandName!).lowercased().contains(searchText.lowercased()))
            }
        } else {
            self.filteredRecipes = self.arrShoesBuyerProduct
            searchBar.resignFirstResponder()
        }

        objTable.reloadData();

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }

    
    func searchBarCancelButtonClicked(_searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }

}

extension HomeVC {
    func segmentLoadData(){
        checkCategory = "1"
        
        DispatchQueue.main.async {
            self.getBuyerProductList()
        }
        
        sgTextOnlyBar.selectorType = .bottomBar
        sgTextOnlyBar.normalFont = UIFont(name:"Helvetica", size: 14)!
        sgTextOnlyBar.SelectedFont = UIFont(name: "Helvetica-Bold", size: 14)!
        
        
        //Using callbacks
        sgTextOnlyBar.onValueChanged = { [self] index in
            print("I have selected index \(index) from WMSegment!")

            if index == 0 {

                checkCategory = "1"
                self.objTable.reloadData()

            }
            if index == 1 {
                checkCategory = "2"
                self.objTable.reloadData()

            }
            if index == 2 {
                checkCategory = "3"
                self.objTable.reloadData()

            }


        }
    }
}



extension HomeVC {
    func getBuyerProductList (){
        
        ProgressHUD.show("Product Loading...", interaction: false)
        
        
        
        let buyerRef = getBuyerProducts(buyerRef: defaultsHome.value(forKey: "DefaultsbuyerRef") as! String)
        BuyerAPIManager.shareInstance.callingBuyergetProductAPI(BuyerProducts: buyerRef) {(result) in
            
            switch result{
            case.success(let json):
                print(json!)
                
                ProgressHUD.dismiss()
                self.arrSneakersBuyerProduct = (json as! ResponsegetSellerProducts).sneakers!
                self.arrShoesBuyerProduct = (json as! ResponsegetSellerProducts).shoes!
                self.arrBootBuyerProduct = (json as! ResponsegetSellerProducts).boots!
                
                
                self.filteredRecipes =  self.arrShoesBuyerProduct
                
                
                self.objTable.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}

extension HomeVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkCategory == "1" {
            
            return  self.filteredRecipes.count
        }
        if checkCategory == "2" {
            return arrSneakersBuyerProduct.count
        }
        
        else {
            return arrBootBuyerProduct.count
        }

    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        
        if checkCategory == "1" {
            
            let SellerProductModel =  self.filteredRecipes[indexPath.row]
            

            
            //TODO:- Set Defualt Img To Product Cover Image
            let imgProductCover = SellerProductModel.productCoverImage
            if imgProductCover == "" {
                
                cell.imgShoes.image =  UIImage(imageLiteralResourceName:"NoImg.png")
            }
            else
            {
                let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrShoesBuyerProduct[indexPath.row].productCoverImage!)")
                cell.imgShoes?.kf.setImage(with: imgURL)
                
            }
            
            // TODO:- Check Favourite ID of Product
            
            //TODO:- Assign Value to Cell Label
            cell.lblShoeName.text = SellerProductModel.brandName
            cell.lblPrice.text = "\("$")\(SellerProductModel.productPrice!)"
            cell.vwStarRating.rating = Double(Float(SellerProductModel.AverageRating!)!)
            
            

            //return cell
        }
        
        if checkCategory == "2" {
            
            let SellerSneakerModel = arrSneakersBuyerProduct[indexPath.row]
            
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrSneakersBuyerProduct[indexPath.row].productCoverImage!)")
            
            // print("here is the URL of IMG:",imgURL!)
            cell.imgShoes?.kf.setImage(with: imgURL)

            
            cell.lblShoeName.text = SellerSneakerModel.brandName
            cell.lblPrice.text =  "\("$")\(SellerSneakerModel.productPrice!)"
            cell.vwStarRating.rating = Double(Float(SellerSneakerModel.AverageRating!)!)

            //return cell
        }
        
        else if checkCategory == "3" {
            let SellerBootProductModel = arrBootBuyerProduct[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrBootBuyerProduct[indexPath.row].productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            cell.lblShoeName.text = SellerBootProductModel.brandName
            cell.lblPrice.text = "\("$")\(SellerBootProductModel.productPrice!)"
            cell.vwStarRating.rating = Double(Float(SellerBootProductModel.AverageRating!)!)
            

            //  return cell
            
        }

        //TODO: btn Favourite Action
        
        cell.btnFavourite.tag = indexPath.row
        cell.btnFavourite .addTarget(self, action: #selector(btnFavouriteItemClicked), for:.touchUpInside)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetails =  self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as! ProductDetailVC
        
        if checkCategory == "1" {
            productRef = arrShoesBuyerProduct[indexPath.row].productRef
        }
        if checkCategory == "2"{
            productRef = arrSneakersBuyerProduct[indexPath.row].productRef
        }
        if checkCategory == "3" {
            productRef = arrBootBuyerProduct[indexPath.row].productRef
        }
        
        let Defaults = UserDefaults.standard
        Defaults.set(productRef, forKey: "DefaultsproductRef")
        self.navigationController?.pushViewController(productDetails, animated: true)
    }
    

    
}


//MARK:- Button remove Cart Item Clicked
extension HomeVC{
    @objc func btnFavouriteItemClicked(sender: UIButton){
        
        //        selecteCartRef = self.arrCartData[sender.tag].cartRef!
        //        print(selecteCartRef)
        //        self.callingRemoveCartAPI()
        

        if checkCategory == "1" {
            productRef = arrShoesBuyerProduct[sender.tag].productRef
        }
        if checkCategory == "2"{
            productRef = arrSneakersBuyerProduct[sender.tag].productRef
        }
        if checkCategory == "3" {
            productRef = arrBootBuyerProduct[sender.tag].productRef
        }
        
        
        
        sender.isSelected.toggle()
        
        if sender.isSelected {
            print("selected")
            
            strActionFav = "1"
            self.addProductToFavourite()
            
            //  straddressRef = arrShippingAddress[sender.tag].addressRef!
            
        }
        else {
            print("Not selected")
            strActionFav = "0"
            self.addProductToFavourite()
            
        }

    }
}



extension HomeVC {
    func addProductToFavourite(){
        
        ProgressHUD.show("Product Loading...", interaction: false)

        let addFavouriteParma = addFavoriteModel(buyerRef:defaultsHome.value(forKey: "DefaultsbuyerRef") as! String , productRef: productRef! ,action:strActionFav!)
        print(addFavouriteParma)
        BuyerAPIManager.shareInstance.addFavoriteAPI(addFavoriteParam: addFavouriteParma) {(result) in
            
            switch result{
            case.success(let json):
                ProgressHUD.dismiss()
                print(json!)


            //  self.objTable.reloadData()

            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}
