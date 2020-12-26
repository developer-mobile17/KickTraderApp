//
//  SellerEarningDetailsVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

struct EarningDetailsData {
    let Ordertitle: String!
    let OrderDate: String!
    let OrderPrice: String!
}

class SellerEarningDetailsVC: UIViewController {
    @IBOutlet var lblHeaderTitle: UILabel!
    var arrEarningDetails = [EarningDetailsData]()
    var strHeader : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblHeaderTitle.text = strHeader
        
        arrEarningDetails = [EarningDetailsData(Ordertitle: "Cancelled Order", OrderDate: "24 October,2020",OrderPrice: "$45"),
                            EarningDetailsData(Ordertitle: "Cancelled Appointmlents", OrderDate: "24 October,2020", OrderPrice: "$55")
        ]
       
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}

extension SellerEarningDetailsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrEarningDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerEarningDetailCell", for: indexPath) as! SellerEarningDetailCell
        
        let EarningDetailModel =  arrEarningDetails[indexPath.row]
        cell.lblOrderTitle.text = EarningDetailModel.Ordertitle
        cell.lblOrderDate.text = EarningDetailModel.OrderDate
        cell.lblOrderPrice.text = EarningDetailModel.OrderPrice
        
        
        return cell
    }
    
    
}
