//
//  SellerHomeVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


class SellerHomeVC: UIViewController {
    @IBOutlet var objScroll : UIScrollView!
    @IBOutlet var objTbl : UITableView!
    
    
    //TODO:- Seller Order Details
    
    
    @IBOutlet var imgSellerShoe: UIImageView!
    @IBOutlet var lblShopName: UILabel!
    @IBOutlet var lblShopDesc: UILabel!
    
    
    
    @IBOutlet var lblTotolOrder: UILabel!
    @IBOutlet var lblEarnToday: UILabel!
    @IBOutlet var lblOrderQueue: UILabel!
    @IBOutlet var lblInProgress: UILabel!
    
    
    var arrEarnings = [EarningDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callingGetSellerEarningAPI()
        self.objTbl.tableFooterView = UIView()
        objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height:1200))
        
    }
    
    // Load Earning  Temp Data
    func EarningDataLoad(){
        
    }
    
    @IBAction func actionBiddingRequest(_ sender: Any) {
        let BiddingReq = self.storyboard?.instantiateViewController(identifier: "BindingRequestVC") as!BindingRequestVC
        self.navigationController?.pushViewController(BiddingReq, animated: true)
        
    }
}



//MARK:- Get Seller Bid Request API
extension SellerHomeVC {
    func callingGetSellerEarningAPI(){
        
        ProgressHUD.show("Loading...", interaction: false)
        

        
      //  let getSellerEarningParam = SellerGetEarningRequest(sellerRef: "gdj6Xt0Ik3XEj")
        
       let getSellerEarningParam = SellerGetEarningRequest(sellerRef: UserDefaults.standard.value(forKey: "DefaultssellerRef") as! String)
//
//
        APIManger.shareInstance.callingGetEarningsAPI(SellerGetEarningParam: getSellerEarningParam) {(result) in
            
            switch result{
            case.success(let json):
              //  print(json!)
                
                ProgressHUD.dismiss()
                let getSellerEarning = (json as! SellerGetEarningResponse).earningDetails
                
                
                
                self.arrEarnings.append(getSellerEarning!)
                print(self.arrEarnings)
                
                self.lblShopName.text = getSellerEarning?.sellerDetail?.full_Name
                self.lblShopDesc.text = getSellerEarning?.sellerDetail?.shop_description
                
                self.lblTotolOrder.text = getSellerEarning?.totalOrders
                self.lblEarnToday.text =  "\("$")\(String(getSellerEarning?.earnedToday ?? 00))"
                self.lblOrderQueue.text =  String(getSellerEarning?.orderQueue ?? 00)
                self.lblInProgress.text = getSellerEarning?.inProgress
                self.objTbl.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
    
        }
  
    }
}




extension SellerHomeVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrEarnings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerHomeCell", for: indexPath) as! SellerHomeCell
        
        let EarningDataModel = arrEarnings[indexPath.row]
    
        cell.lblTitle?.text =  "\("Personal Balance            ")\(String(EarningDataModel.personalBalance!))"
      //  cell.lblPrice?.text = EarningDataModel.priceEarning
        
        return cell
    }
    
    
}
