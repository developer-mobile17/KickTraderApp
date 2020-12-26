//
//  SellerHomeVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


struct EarningData {
    let titleEarning: String!
    let priceEarning: String!
}
class SellerHomeVC: UIViewController {
    @IBOutlet var objScroll : UIScrollView!
    @IBOutlet var objTbl : UITableView!
    var arrEarnings = [EarningData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EarningDataLoad()
        self.objTbl.tableFooterView = UIView()
        objScroll.contentSize = (CGSize(width: self.objScroll.frame.size.width, height:1200))
        
    }
    
    // Load Earning  Temp Data
    func EarningDataLoad(){
        arrEarnings = [EarningData(titleEarning: "Personal balance", priceEarning: "$50"), EarningData(titleEarning: "Avg. Selling Price", priceEarning: "$18"),EarningData(titleEarning: "Pending Clearance", priceEarning:"$18"),
                       EarningData(titleEarning: "Earning in September", priceEarning: "$150"),
                       EarningData(titleEarning: "Active Orders", priceEarning: "2 ($180)"),
                       EarningData(titleEarning: "Cancelled Orders", priceEarning: "2 ($180)")
            
        ]
        
    }
    
    @IBAction func actionBiddingRequest(_ sender: Any) {
        let BiddingReq = self.storyboard?.instantiateViewController(identifier: "BindingRequestVC") as!BindingRequestVC
        self.navigationController?.pushViewController(BiddingReq, animated: true)
        
    }
}


extension SellerHomeVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrEarnings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerHomeCell", for: indexPath) as! SellerHomeCell
        
        let EarningDataModel = arrEarnings[indexPath.row]
        cell.lblTitle?.text = EarningDataModel.titleEarning
        cell.lblPrice?.text = EarningDataModel.priceEarning
        
        return cell
    }
    
    
}
