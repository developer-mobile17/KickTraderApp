//
//  BiddingReqDetailsVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 04/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class BiddingReqDetailsVC: UIViewController {
    
    let defaults = UserDefaults.standard
    var arrBidRequest = [BidArray]()
    var strNavigationTitle:String!
    var bidStatus: String!
    var bidRef: String!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }

        
        self.navigationItem.title = strNavigationTitle
        
        let defaults = UserDefaults.standard
              if let data = defaults.data(forKey: "SavedItemArray") {
                arrBidRequest = try! PropertyListDecoder().decode([BidArray].self, from: data)
                
              }
        
        
    }
 
}

extension BiddingReqDetailsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBidRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiddingDetailsCell", for: indexPath) as! BiddingDetailsCell
        
        let BidReqData = arrBidRequest[indexPath.row]
        let imgURL = URL(string:"\(PROFILE_IMAGE)\(BidReqData.profile_Image!)")
        cell.imgProfile.kf.setImage(with: imgURL)
        cell.lblName.text = BidReqData.full_Name
       // cell.lblSize.text =  "No Data"
      //  cell.lblColor.backgroundColor = UIColor(hexFromString: BidReqData.coloToProductRef!)
        let strBidPrice = BidReqData.bidPrice!
        cell.lblBidPrice.text = "\("Bid Price: $")\(strBidPrice)"
        
        
        cell.btnAcceptBid.tag = indexPath.row
        cell.btnAcceptBid .addTarget(self, action: #selector(btnAcceptBidClicked), for:.touchUpInside)
        
        
        cell.btnRejectBid.tag = indexPath.row
        cell.btnRejectBid .addTarget(self, action: #selector(btnRejectBidClicked), for:.touchUpInside)
        
        
        return cell
    }
    
    
}


//MARK:- Button Delete Item Clicked
extension BiddingReqDetailsVC{
    @objc func btnAcceptBidClicked(sender: UIButton){
        bidStatus = "1"
        bidRef = arrBidRequest[sender.tag].cartRef
        self.callingAcceptBidReqAPI()
    
    }
}


//MARK:- Button Delete Item Clicked
extension BiddingReqDetailsVC{
    @objc func btnRejectBidClicked(sender: UIButton){
     bidStatus = "0"
     bidRef = arrBidRequest[sender.tag].cartRef
     self.callingAcceptBidReqAPI()
    
    }
}


//MARK:- Get Seller Bid Request API
extension BiddingReqDetailsVC {
    func callingAcceptBidReqAPI(){
        
        ProgressHUD.show("Loading...", interaction: false)
        
        let sellerAcceptBidParam = sellerAcceptRejectBidModel(bidStatus: bidStatus, bidRef: bidRef)
         
        
        APIManger.shareInstance.callingAcceptBidAPI(sellerAcceptRejectBidParam: sellerAcceptBidParam) {(result) in
            
            switch result{
            case.success(let json):
                print(json!)
                
                ProgressHUD.dismiss()
               let msz = (json as! sellerAcceptRejectBidModelResponse).msg
                print(msz)
               
              //  self.objTable.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
    
        }
  
    }
}
