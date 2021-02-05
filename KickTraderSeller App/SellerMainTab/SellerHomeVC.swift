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

    
    //TODO:- Seller Order Details
    
    
    @IBOutlet var imgSellerShoe: UIImageView!
    @IBOutlet var lblShopName: UILabel!
    @IBOutlet var lblShopDesc: UILabel!
    
    
    
    @IBOutlet var lblTotolOrder: UILabel!
    @IBOutlet var lblEarnToday: UILabel!
    @IBOutlet var lblOrderQueue: UILabel!
    @IBOutlet var lblInProgress: UILabel!


    @IBOutlet var lblPersonalBalance: UILabel!
    @IBOutlet var lblAvgSellingPrice: UILabel!
    @IBOutlet var lblPendingClearance: UILabel!
    @IBOutlet var lblEarningLastMonth: UILabel!
    @IBOutlet var lblActiveOrder: UILabel!
    @IBOutlet var lblCancelledOrders: UILabel!
    
    
    
    var arrEarnings = [EarningDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        self.callingGetSellerEarningAPI()
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


                self.lblShopName.text = getSellerEarning?.sellerDetail?.full_Name
                self.lblShopDesc.text = getSellerEarning?.sellerDetail?.shop_description
                self.lblTotolOrder.text = getSellerEarning?.totalOrders
                self.lblEarnToday.text =  "\("$")\(String(getSellerEarning?.earnedToday ?? 00))"
                self.lblOrderQueue.text =  String(getSellerEarning?.orderQueue ?? 00)
                self.lblInProgress.text = getSellerEarning?.inProgress




                //TODO:- Show Earning Detail Here
                self.lblPersonalBalance.text = "\("$")\(String(getSellerEarning?.personalBalance ?? 00))"
                self.lblAvgSellingPrice.text = "\("$")\(getSellerEarning?.avgSellingPrice ?? "No Data")"
                self.lblPendingClearance.text = "\("$")\(String(getSellerEarning?.pendingClearance ?? 00))"
                self.lblEarningLastMonth.text = "\("$")\(getSellerEarning?.lastMonthEarnings ?? "No Data")"
                self.lblActiveOrder.text = "\(getSellerEarning?.activeAppointmentCount ?? "No Data") \("$")\(getSellerEarning?.activeAppointment ?? "No Data")"
                self.lblCancelledOrders.text = "\(getSellerEarning?.cancelOrderCount ?? "No Data") \("$")\(getSellerEarning?.cancelledAppointment ?? "No Data")"



                
            case.failure(let err):
                print(err.localizedDescription)
            }
    
        }
  
    }
}


