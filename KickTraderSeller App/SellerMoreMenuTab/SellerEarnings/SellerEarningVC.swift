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
    var arrSellerEarnings = [SellerEarningData]()

    override func viewDidLoad() {
        super.viewDidLoad()

       arrSellerEarnings = [SellerEarningData(earningTitle: "Cancelled Orders", earningPrice: "$50"),SellerEarningData(earningTitle: "Pending Clearance", earningPrice: "$20"),SellerEarningData(earningTitle: "Withdraw", earningPrice: "$45"),SellerEarningData(earningTitle: "Cleared", earningPrice: "$145")]
        
        
        self.objTbl.tableHeaderView = self.objView
        
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
