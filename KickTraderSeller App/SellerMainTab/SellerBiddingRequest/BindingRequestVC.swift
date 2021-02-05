//
//  BindingRequestVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 04/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


class BindingRequestVC: UIViewController {
    
    @IBOutlet var objTable: UITableView!
    var arrBindingRequest = [BidItem]()
    var arrBidArrCount = [BidArray]()
    var defaultGetBids = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        self.callingSellerBidReqAPI()
    }
     
    @IBAction func actionBack(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }

}


//MARK:- Get Seller Bid Request API
extension BindingRequestVC {
    func callingSellerBidReqAPI(){
        
        ProgressHUD.show("Loading...", interaction: false)
        
        
        
      //  guard let sellerRef =  defaultGetBids.value(forKey: "DefaultssellerRef") as! String) else {return}
        
       // let sellerBiddingReqParam = sellerGetBidsModel(sellerRef: defaultGetBids.value(forKey: "DefaultssellerRef") as! String)
        let sellerBiddingReqParam = sellerGetBidsModel(sellerRef: defaultGetBids.value(forKey: "DefaultssellerRef") as! String)
         
        
        APIManger.shareInstance.callingSellergetBidsAPI(sellerGetBidsParam: sellerBiddingReqParam) {(result) in
            
            switch result{
            case.success(let json):
                print(json!)
                
                ProgressHUD.dismiss()
                self.arrBindingRequest = (json as! sellerGetBidsModelResponse).bidItem!
               
                self.objTable.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
    
        }
  
    }
}




extension BindingRequestVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrBindingRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "BindingRequestCell", for: indexPath) as! BindingRequestCell
        
        let BindingReqModel = arrBindingRequest[indexPath.row]
        
        
       
        
        let bidcount = arrBindingRequest[indexPath.row].bidArray?.count
        cell.lblbidCount.text =  "\(String(bidcount!)) \("Bid")"
        let imgURL = URL(string:"\(PRODUCT_COVER_IMAGE)\(BindingReqModel.productCoverImage!)")
        cell.imgShoes.kf.setImage(with: imgURL)
        let strBidPrice = BindingReqModel.bidPrice!
        let strShoeSize = BindingReqModel.sizeName!
        cell.lblPrice.text = "\("Bid Price: $")\(strBidPrice)"
        cell.lblShoeName.text = BindingReqModel.productName
        cell.lblShoeBrandName.text = BindingReqModel.brandName
        cell.lblShoeSize.text = "\("Size: ")\(strShoeSize)"
        cell.lblShoeColor.backgroundColor = UIColor(hexFromString:BindingReqModel.colorCode!)
        
        
        
        
        cell.btnViewBids.tag = indexPath.row
        cell.btnViewBids .addTarget(self, action: #selector(btnViewBidClicked), for:.touchUpInside)
        
        
        
        return cell
    }
    
  
}



//MARK:- Button Delete Item Clicked
extension BindingRequestVC{
    @objc func btnViewBidClicked(sender: UIButton){
        
        
        guard let bidDetail = storyboard?.instantiateViewController(identifier: "BiddingReqDetailsVC") as? BiddingReqDetailsVC else{
            
            return
        }
        
        
        //TODO:- Pass StructArray into UserDefaults
        
        let selectedBid = arrBindingRequest[sender.tag].bidArray
        if let data = try? PropertyListEncoder().encode(selectedBid) {
            
            UserDefaults.standard.set(data, forKey: "SavedItemArray")
            
        }
        
        bidDetail.strNavigationTitle = arrBindingRequest[sender.tag].brandName
        let navController = UINavigationController(rootViewController: bidDetail)
        present(navController, animated: true)
    
    
    }
}
