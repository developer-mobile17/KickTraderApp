//
//  SellerSearchProducctTab.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import WMSegmentControl



class SellerSearchProducctTab: UIViewController {
    @IBOutlet weak var objTable: UITableView!
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    
    var arrShoesSellerProduct = [Shoes]()
    var arrSneakersSellerProduct = [Sneakers]()
    var arrBootSellerProduct = [Boot]()
    
    var checkCategory: String?
    var productRef:String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        checkCategory = "1"
        self.getSellerProductList()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        checkCategory = "1"
        self.getSellerProductList()
        objTable.reloadData()
    }
   
    
}


extension SellerSearchProducctTab {
    func getSellerProductList (){
        
        let sellerRef = getSellerProducts(sellerRef: UserDefaults.standard.value(forKey: "DefaultssellerRef") as! String)
        APIManger.shareInstance.callinggetProductAPI(sellerProduct:sellerRef) {(result) in
          
            switch result{
            case.success(let json):
                print(json!)
                
                self.arrSneakersSellerProduct = (json as! ResponsegetSellerProducts).sneakers!
                self.arrShoesSellerProduct = (json as! ResponsegetSellerProducts).shoes!
                self.arrBootSellerProduct = (json as! ResponsegetSellerProducts).boots!
                self.objTable.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
            
        }
        
    }
}

extension SellerSearchProducctTab {
    
    @IBAction func segmentValueChange(_ sender: WMSegment) {
        print("selected index = \(sender.selectedSegmentIndex)")
        
        objTable.reloadData()
    }
    
    @IBAction func actionAddProduct(_ sender: Any) {
        
//        DispatchQueue.main.async {
//            ProgressHUD.show()
//        }
//
        
        
        let vcAddProduct = self.storyboard?.instantiateViewController(identifier: "SellerAddProductVC")as! SellerAddProductVC
        self.navigationController?.pushViewController(vcAddProduct, animated: true)
    }
    
}

extension SellerSearchProducctTab: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkCategory == "1" {
            
            return arrShoesSellerProduct.count
        }
        if checkCategory == "2" {
            return arrSneakersSellerProduct.count
        }
        
        else {
            return arrBootSellerProduct.count
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SellerSearchCell", for: indexPath) as! SellerSearchCell
        
        
        if checkCategory == "1" {
            
            let SellerProductModel = arrShoesSellerProduct[indexPath.row]
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerProductModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            cell.lblBrandName.text = SellerProductModel.brandName
            cell.lblShoeName.text = SellerProductModel.productName
            cell.lblPrice.text = "\("$")\(SellerProductModel.productPrice!)"
            
          
        }
        
        if checkCategory == "2" {
            
            let SellerProductModel = arrSneakersSellerProduct[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerProductModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            cell.lblBrandName.text = SellerProductModel.brandName
            cell.lblShoeName.text = SellerProductModel.productName
            cell.lblPrice.text =  "\("$")\(SellerProductModel.productPrice!)"
            
            
        }
        
        else if checkCategory == "3"
        {
            let SellerProductModel = arrBootSellerProduct[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerProductModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            cell.lblBrandName.text = SellerProductModel.brandName
            cell.lblShoeName.text = SellerProductModel.productName
            cell.lblPrice.text = "\("$")\(SellerProductModel.productPrice!)"
           
           
           
            
        }
        
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit .addTarget(self, action: #selector(btnEditClicked), for:.touchUpInside)
        
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete .addTarget(self, action: #selector(btnDeleteClicked), for:.touchUpInside)
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcProductEdit = self.storyboard?.instantiateViewController(identifier: "SellerProductEditVC")as! SellerProductEditVC
        self.navigationController?.pushViewController(vcProductEdit, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.objTable.deselectRow(at: indexPath, animated: true)
    }
    
    
}

//MARK:- Button Edit Item Clicked
extension SellerSearchProducctTab{
    @objc func btnEditClicked(sender: UIButton){
    
        let vcEditSearch = self.storyboard?.instantiateViewController(identifier: "SearchEditVC") as! SearchEditVC
        if checkCategory == "1"{
            productRef = arrShoesSellerProduct[sender.tag].productRef
            
        }
       else if checkCategory == "2" {
        productRef = arrSneakersSellerProduct[sender.tag].productRef
        }
       else {
        productRef = arrBootSellerProduct[sender.tag].productRef
       }
        
        let defaults = UserDefaults.standard
        defaults.setValue(productRef, forKey: "DefaultsproductRef")
        vcEditSearch.strProductRef = productRef
        self.navigationController?.pushViewController(vcEditSearch, animated: true)
        
    }
}


//MARK:- Button Delete Item Clicked
extension SellerSearchProducctTab{
    @objc func btnDeleteClicked(sender: UIButton){
    
    
    }
}
