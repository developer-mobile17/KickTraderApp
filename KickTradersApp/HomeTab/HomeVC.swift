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
    @IBOutlet var btnImgProfile: UIButton!

    var arrShoesBuyerProduct = [Shoes]()
    var arrSneakersBuyerProduct = [Sneakers]()
    var arrBootBuyerProduct = [Boot]()
    
    
    var filteredShoes = [Shoes]()
    var filteredSneakers = [Sneakers]()
    var filteredBoot = [Boot]()
    var searching = false

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

        // overrideUserInterfaceStyle is available with iOS 13
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }


        NotificationCenter.default.addObserver(self, selector: #selector(ClickedOnNotification), name: Notification.Name(rawValue: "GoToChatListAfterNotificationClicked"), object: nil)
        self.searchBar?.delegate = self
        self.segmentLoadData()
        self.getProfileImg()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getProfileImg()
        
        
        checkCategory = "1"
        DispatchQueue.main.async {
            self.getBuyerProductList()
        }

    }



    @objc func ClickedOnNotification(notification: NSNotification) {

        DispatchQueue.main.async {




            //            let goToChatList =  self.storyboard?.instantiateViewController(identifier: "ChatVC") as! ChatVC
            //            self.navigationController?.pushViewController(goToChatList, animated: true)
        }

    }



    @IBAction func actionGoToProfile(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileVC else{

            return
        }
        present(vc, animated: true)
        
    }

    @IBAction func actionGoToFavouriteUI(_ sender: Any) {


        guard let vc = storyboard?.instantiateViewController(identifier: "FavouriteProductVc") as? FavouriteProductVc else{

            return
        }
        present(vc, animated: true)
    }
    //TODO:-  Get the User Profile
    func getProfileImg (){
        btnImgProfile.layer.cornerRadius = 12
        btnImgProfile.clipsToBounds = true
        strImgURL = defaultsHome.value(forKey: "Defaultsprofile_Image")! as? String
        if strImgURL == nil {
            // print("No Profile Img")
        }
        else {
            let imgProfileURL =  URL(string: "\(PROFILE_IMAGE)\(strImgURL!)")
            self.btnImgProfile.kf.setImage(with: imgProfileURL, for: .normal)
        }
        

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
            // print("I have selected index \(index) from WMSegment!")

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
                //  print(json!)
                
                ProgressHUD.dismiss()
                self.arrSneakersBuyerProduct = (json as! ResponsegetSellerProducts).sneakers!
                self.arrShoesBuyerProduct = (json as! ResponsegetSellerProducts).shoes!
                self.arrBootBuyerProduct = (json as! ResponsegetSellerProducts).boots!
                
                
                self.filteredShoes =  self.arrShoesBuyerProduct
                self.filteredSneakers =  self.arrSneakersBuyerProduct
                self.filteredBoot =  self.arrBootBuyerProduct
                
                DispatchQueue.main.async {
                    self.objTable.reloadData()
                }

                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}

extension HomeVC : UITableViewDataSource,UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkCategory == "1" {
            if searching {
                return  self.filteredShoes.count
            }
            else {

                return  self.arrShoesBuyerProduct.count
            }
            

        }
        if checkCategory == "2" {

            if searching {
                return filteredSneakers.count
            }
            else {
                return arrSneakersBuyerProduct.count
            }

        }
        
        else {
            if searching {
                return filteredBoot.count
            }

            else {
                return arrBootBuyerProduct.count
            }

        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        //MARK:- SHOE Category Logic Here
        if checkCategory == "1" {

            if searching {

                let SellerProductModel =  self.filteredShoes[indexPath.row]

                //TODO:- Set Defualt Img To Product Cover Image
                let imgProductCover = SellerProductModel.productCoverImage

                // cell.imgShoes.showLoading(color: .systemRed)
                if imgProductCover == "" {

                    cell.imgShoes.image =  UIImage(imageLiteralResourceName:"NoImg.png")
                }
                else
                {
                    let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(filteredShoes[indexPath.row].productCoverImage!)")
                    cell.imgShoes?.kf.setImage(with: imgURL)
                    //  cell.imgShoes.stopLoading()

                }


                // TODO:- Check Favourite ID of Product

                if let checkFavID = SellerProductModel.favoriteId {
                    print(checkFavID)
                    cell.btnFavourite.isSelected = true

                }
                else
                {
                    cell.btnFavourite.isSelected = false
                }

                //TODO:- Assign Value to Cell Label
                cell.lblShoeName.text = SellerProductModel.brandName
                cell.lblPrice.text = "\("$")\(SellerProductModel.productPrice!)"
                cell.vwStarRating.rating = Double(Float(SellerProductModel.AverageRating!)!)

            }

            else
            {

                let SellerProductModel =  self.arrShoesBuyerProduct[indexPath.row]
                //TODO:- Set Defualt Img To Product Cover Image
                let imgProductCover = SellerProductModel.productCoverImage

                // cell.imgShoes.showLoading(color: .systemRed)
                if imgProductCover == "" {

                    cell.imgShoes.image =  UIImage(imageLiteralResourceName:"NoImg.png")
                }
                else
                {
                    let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrShoesBuyerProduct[indexPath.row].productCoverImage!)")
                    cell.imgShoes?.kf.setImage(with: imgURL)
                    //  cell.imgShoes.stopLoading()
                }
                // TODO:- Check Favourite ID of Product

                if let checkFavID = SellerProductModel.favoriteId {
                    print(checkFavID)
                    cell.btnFavourite.isSelected = true

                }
                else
                {
                    cell.btnFavourite.isSelected = false
                }
                //TODO:- Assign Value to Cell Label
                cell.lblShoeName.text = SellerProductModel.brandName
                cell.lblPrice.text = "\("$")\(SellerProductModel.productPrice!)"
                cell.vwStarRating.rating = Double(Float(SellerProductModel.AverageRating!)!)
            }
        }


        //MARK:- SNEAKER Categoty Logic Here

        if checkCategory == "2" {

            if searching {
                print(self.filteredSneakers.count)
                let SellerSneakerModel = self.filteredSneakers[indexPath.row]
                //  cell.imgShoes.showLoading(color: .systemRed)

                let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(filteredSneakers[indexPath.row].productCoverImage!)")
                cell.imgShoes?.kf.setImage(with: imgURL)
                //   cell.imgShoes.stopLoading()

                //  print("Fav ID of SneakerShoe.",SellerSneakerModel.favoriteId as Any)
                if let checkFavID = SellerSneakerModel.favoriteId {
                    print(checkFavID)
                    cell.btnFavourite.isSelected = true

                }
                else
                {
                    cell.btnFavourite.isSelected = false
                }

                cell.lblShoeName.text = SellerSneakerModel.brandName
                cell.lblPrice.text =  "\("$")\(SellerSneakerModel.productPrice!)"
                cell.vwStarRating.rating = Double(Float(SellerSneakerModel.AverageRating!)!)

            }

            else {

                let SellerSneakerModel = self.arrSneakersBuyerProduct[indexPath.row]
                //  cell.imgShoes.showLoading(color: .systemRed)

                let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrSneakersBuyerProduct[indexPath.row].productCoverImage!)")
                cell.imgShoes?.kf.setImage(with: imgURL)
                //   cell.imgShoes.stopLoading()

                //  print("Fav ID of SneakerShoe.",SellerSneakerModel.favoriteId as Any)
                if let checkFavID = SellerSneakerModel.favoriteId {
                    print(checkFavID)
                    cell.btnFavourite.isSelected = true

                }
                else
                {
                    cell.btnFavourite.isSelected = false
                }

                cell.lblShoeName.text = SellerSneakerModel.brandName
                cell.lblPrice.text =  "\("$")\(SellerSneakerModel.productPrice!)"
                cell.vwStarRating.rating = Double(Float(SellerSneakerModel.AverageRating!)!)


            }


        }
        


        //MARK:- BOOT SHOE Logic Here.

        else if checkCategory == "3" {


            if searching {
                let SellerBootProductModel = self.filteredBoot[indexPath.row]
                //  cell.imgShoes.showLoading(color: .systemRed)

                let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrBootBuyerProduct[indexPath.row].productCoverImage!)")
                cell.imgShoes?.kf.setImage(with: imgURL)
                // cell.imgShoes.stopLoading()

                if let checkFavID = SellerBootProductModel.favoriteId {
                    print(checkFavID)
                    cell.btnFavourite.isSelected = true

                }
                cell.lblShoeName.text = SellerBootProductModel.brandName
                cell.lblPrice.text = "\("$")\(SellerBootProductModel.productPrice!)"
                cell.vwStarRating.rating = Double(Float(SellerBootProductModel.AverageRating!)!)


            }

            else {

                let SellerBootProductModel = self.arrBootBuyerProduct[indexPath.row]
                //  cell.imgShoes.showLoading(color: .systemRed)

                let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(arrBootBuyerProduct[indexPath.row].productCoverImage!)")
                cell.imgShoes?.kf.setImage(with: imgURL)
                // cell.imgShoes.stopLoading()

                if let checkFavID = SellerBootProductModel.favoriteId {
                    print(checkFavID)
                    cell.btnFavourite.isSelected = true

                }
                cell.lblShoeName.text = SellerBootProductModel.brandName
                cell.lblPrice.text = "\("$")\(SellerBootProductModel.productPrice!)"
                cell.vwStarRating.rating = Double(Float(SellerBootProductModel.AverageRating!)!)

            }
            //TODO: btn Favourite Action

            cell.btnFavourite.tag = indexPath.row
            cell.btnFavourite .addTarget(self, action: #selector(btnFavouriteItemClicked), for:.touchUpInside)


            
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetails =  self.storyboard?.instantiateViewController(identifier: "ProductDetailVC") as! ProductDetailVC
        
        if checkCategory == "1" {
            if searching {
                productRef = filteredShoes[indexPath.row].productRef

            }
            else {
                productRef = arrShoesBuyerProduct[indexPath.row].productRef
            }

        }
        if checkCategory == "2"{

            if searching {
                productRef = filteredSneakers[indexPath.row].productRef

            }
            else {
                productRef = arrSneakersBuyerProduct[indexPath.row].productRef
            }

        }
        if checkCategory == "3" {
            if searching {
                productRef = filteredBoot[indexPath.row].productRef

            }
            else {
                productRef = arrBootBuyerProduct[indexPath.row].productRef
            }

        }
        
        let Defaults = UserDefaults.standard
        Defaults.set(productRef, forKey: "DefaultsproductRef")
        self.navigationController?.pushViewController(productDetails, animated: true)
        self.searchBar.searchTextField.endEditing(true)
    }
}


//MARK:- SearachBar Delegate
extension HomeVC {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredShoes.removeAll()

        searching = true


        if checkCategory == "1" {
            if let searchText = searchBar.text, !searchText.isEmpty {

                self.filteredShoes = self.arrShoesBuyerProduct.filter { filterSearch in
                    guard filterSearch.brandName != nil else { return false }
                    return ((filterSearch.brandName!).lowercased().contains(searchText.lowercased()))
                }

            } else {
                self.filteredShoes = self.arrShoesBuyerProduct
                searchBar.resignFirstResponder()
            }

        }


        if checkCategory == "2" {
            if let searchText = searchBar.text, !searchText.isEmpty {
                self.filteredSneakers = self.arrSneakersBuyerProduct.filter { recipe in
                    guard recipe.brandName != nil else { return false }
                    return ((recipe.brandName!).lowercased().contains(searchText.lowercased()))
                }
            } else {
                self.filteredSneakers = self.arrSneakersBuyerProduct
                searchBar.resignFirstResponder()
            }

        }



        if checkCategory == "3" {
            if let searchText = searchBar.text, !searchText.isEmpty {
                self.filteredBoot = self.arrBootBuyerProduct.filter { recipe in
                    guard recipe.brandName != nil else { return false }
                    return ((recipe.brandName!).lowercased().contains(searchText.lowercased()))
                }
            } else {
                self.filteredBoot = self.arrBootBuyerProduct
                searchBar.resignFirstResponder()
            }

        }

        // searching = true
        objTable.reloadData();


    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }


    func searchBarCancelButtonClicked(_searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
}

//MARK:- Button remove Cart Item Clicked
extension HomeVC{
    @objc func btnFavouriteItemClicked(sender: UIButton){



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
        
        ProgressHUD.show(interaction: false)
        let addFavouriteParma = addFavoriteModel(buyerRef:defaultsHome.value(forKey: "DefaultsbuyerRef") as! String , productRef: productRef! ,action:strActionFav!)
        // print(addFavouriteParma)
        BuyerAPIManager.shareInstance.addFavoriteAPI(addFavoriteParam: addFavouriteParma) {(result) in
            
            switch result{
            case.success(let json):
                ProgressHUD.dismiss()
                print((json as! addFavoriteModelResponse).msg)
                AppSnackBar.make(in: self.view, message: ((json as! addFavoriteModelResponse).msg), duration: .lengthShort).show()
                self.getBuyerProductList()
            case.failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
}
