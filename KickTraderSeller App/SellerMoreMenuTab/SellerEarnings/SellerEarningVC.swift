//
//  SellerEarningVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 05/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
struct SellerEarningData {
    let earningTitle: String!
    let earningPrice: String!
}



class SellerEarningVC: UIViewController {
    @IBOutlet var objView: UIView!
    @IBOutlet var objTbl: UITableView!

    @IBOutlet var lblPersonalBalance: UILabel!
    @IBOutlet var lblAvgSellingPrice: UILabel!
    @IBOutlet var lblLastMonthEarning: UILabel!
    @IBOutlet var lblActiveAppoinemnt: UILabel!
    @IBOutlet var lblPendingClearance: UILabel!
    @IBOutlet var lblCancelAppointment: UILabel!
    



    
    var arrSellerEarnings = [SellerEarningData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

       arrSellerEarnings = [SellerEarningData(earningTitle: "Cancelled Orders", earningPrice: "$50"),SellerEarningData(earningTitle: "Pending Clearance", earningPrice: "$20"),SellerEarningData(earningTitle: "Withdraw", earningPrice: "$45"),SellerEarningData(earningTitle: "Cleared", earningPrice: "$145")]
        
        
        self.objTbl.tableHeaderView = self.objView
        self.callingGetSellerEarningAPI()
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    

}

extension SellerEarningVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSellerEarnings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerEarningCell", for: indexPath) as! SellerEarningCell
        
        let sellerEarningModel = arrSellerEarnings[indexPath.row]
        
        cell.lblEarningTitle?.text = sellerEarningModel.earningTitle
        cell.lblEaringPrice?.text = sellerEarningModel.earningPrice
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedOrder = arrSellerEarnings[indexPath.row].earningTitle

        
        let detailEarning =  self.storyboard?.instantiateViewController(identifier: "SellerEarningDetailsVC") as!SellerEarningDetailsVC
        
        detailEarning.strHeader = selectedOrder
        
        self.navigationController?.pushViewController(detailEarning, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        let Color = UIColor(red: 200.0/255.0, green: 16.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        
        if section == 0 {
            label.text = "Earnings:"
            label.textColor = Color
           // label.font = label.font.withSize(15)
            label.font = UIFont.boldSystemFont(ofSize: 15.0)
        }
        else{
            
        }
        
        return label
        
    }
    
    
    
}



//MARK:- Get Seller Bid Request API
extension SellerEarningVC {
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

                //TODO:- Show Earning Detail Here
                self.lblPersonalBalance.text = "\("$")\(String(getSellerEarning?.personalBalance ?? 00))"
                self.lblAvgSellingPrice.text = "\("$")\(getSellerEarning?.avgSellingPrice ?? "No Data")"
                self.lblPendingClearance.text = "\("$")\(String(getSellerEarning?.pendingClearance ?? 00))"
                self.lblLastMonthEarning.text = "\("$")\(getSellerEarning?.lastMonthEarnings ?? "No Data")"
                self.lblActiveAppoinemnt.text = "\("$")\(getSellerEarning?.activeAppointment ?? "No Data")"
                self.lblCancelAppointment.text = "\("$")\(getSellerEarning?.cancelledAppointment ?? "No Data")"

            case.failure(let err):
                print(err.localizedDescription)
            }

        }

    }
}



