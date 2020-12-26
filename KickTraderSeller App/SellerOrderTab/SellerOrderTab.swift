//
//  SellerOrderTab.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import WMSegmentControl

class SellerOrderTab: UIViewController {
    @IBOutlet weak var objTable: UITableView!
    @IBOutlet weak var sgTextOnlyBar: WMSegment!
    
    var arrSellerPendingOrder = [Pending]()
    var arrSellerUpcomingOrder = [Upcoming]()
    var arrSellerCancelledOrder = [Cancelled]()
    var arrSellerHistoryOrder = [History]()
    
    var checkCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCategory = "1"
        self.SellerOrderAPI()
        self.objTable.reloadData()
        sgTextOnlyBar.selectorType = .bottomBar
        sgTextOnlyBar.normalFont = UIFont(name:"Helvetica", size: 14)!
        sgTextOnlyBar.SelectedFont = UIFont(name: "Helvetica-Bold", size: 14)!
        // Do any additional setup after loading the view.
        
     
    }
   
}

extension SellerOrderTab {
    @IBAction func segmentValueChange(_ sender: WMSegment) {
        print("selected index = \(sender.selectedSegmentIndex)")
        
        
        if sender.selectedSegmentIndex == 0 {
            
            checkCategory = "1"
            self.objTable.reloadData()
            
        }
        if sender.selectedSegmentIndex == 1 {
            checkCategory = "2"
            self.objTable.reloadData()
            
        }
        if sender.selectedSegmentIndex == 2 {
            checkCategory = "3"
            self.objTable.reloadData()
            
        }
        
        if sender.selectedSegmentIndex == 3 {
            checkCategory = "4"
            self.objTable.reloadData()
            
        }
        
        
        objTable.reloadData()
    }
    
}

extension SellerOrderTab {
    func SellerOrderAPI(){
        let sellerOrderRef = SellerOrderModel(sellerRef: "gdj6Xt0Ik3XEj")
        APIManger.shareInstance.callingSellerOrderProductAPI(sellerorderProduct: sellerOrderRef) {(result) in
            
            switch result{
            case.success(let json):
                print(json!)
                
                self.arrSellerPendingOrder = ((json as! ResponseSellerOrderModel).orders?.pending!)!
               // print(self.arrSellerPendingOrder)
                
                
                self.arrSellerUpcomingOrder = ((json as! ResponseSellerOrderModel).orders?.upcoming!)!
                self.arrSellerCancelledOrder = ((json as! ResponseSellerOrderModel).orders?.cancelled!)!
                self.arrSellerHistoryOrder = ((json as! ResponseSellerOrderModel).orders?.history!)!
                self.objTable.reloadData()
                
            case.failure(let err):
                print(err.localizedDescription)
            }
            
            
            
        }
    }
}



extension SellerOrderTab: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if checkCategory == "1" {
            
            return arrSellerPendingOrder.count
            
        }
        if checkCategory == "2" {
            return arrSellerUpcomingOrder.count
        }
        
        if checkCategory == "3" {
            return arrSellerCancelledOrder.count
        }
        
        
        else {
            return arrSellerHistoryOrder.count
        }
     
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SellerOrderCell", for: indexPath) as! SellerOrderCell
        
        
        if checkCategory == "1" {
            
            let SellerOrderModel = arrSellerPendingOrder[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerOrderModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            
            // cell.imgShoes.image = UIImage(imageLiteralResourceName: SellerOrderModel.ShoeImg)
            cell.lblBrandName.text = SellerOrderModel.brandName
            cell.lblShoeName.text = SellerOrderModel.productName
            cell.lblSize.text = SellerOrderModel.sizeName
            cell.lblColor.backgroundColor = UIColor.init(hexFromString: SellerOrderModel.colorCode!)
            cell.lblBidprice.text = "\("$")\(SellerOrderModel.bidPrice!)"
            cell.lblOrderStatus.text = SellerOrderModel.orderStatus
            
            
            
            return cell
        }
        
        if checkCategory == "2" {
            
            let SellerOrderModel = arrSellerUpcomingOrder[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerOrderModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            // cell.imgShoes.image = UIImage(imageLiteralResourceName: SellerOrderModel.ShoeImg)
            cell.lblBrandName.text = SellerOrderModel.brandName
            cell.lblShoeName.text = SellerOrderModel.productName
            cell.lblSize.text = SellerOrderModel.sizeName
            cell.lblColor.backgroundColor = UIColor.init(hexFromString: SellerOrderModel.colorCode!)
            cell.lblBidprice.text = "\("$")\(SellerOrderModel.bidPrice!)"
            cell.lblOrderStatus.text = "No Data"
            
            
            return cell
        }
        
        
        if checkCategory == "3" {
            
            let SellerOrderModel = arrSellerCancelledOrder[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerOrderModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            // cell.imgShoes.image = UIImage(imageLiteralResourceName: SellerOrderModel.ShoeImg)
            cell.lblBrandName.text = SellerOrderModel.brandName
            cell.lblShoeName.text = SellerOrderModel.productName
            cell.lblSize.text = SellerOrderModel.sizeName
            cell.lblColor.backgroundColor = UIColor.init(hexFromString: SellerOrderModel.colorCode!)
            cell.lblBidprice.text = "\("$")\(SellerOrderModel.bidPrice!)"
            cell.lblOrderStatus.text = SellerOrderModel.orderStatus
            
            
            
            
            return cell
        }
        else {
            
            let SellerOrderModel = arrSellerHistoryOrder[indexPath.row]
            
            let imgURL =  URL(string:"\(PRODUCT_COVER_IMAGE)\(SellerOrderModel.productCoverImage!)")
            cell.imgShoes?.kf.setImage(with: imgURL)
            // cell.imgShoes.image = UIImage(imageLiteralResourceName: SellerOrderModel.ShoeImg)
            cell.lblBrandName.text = SellerOrderModel.brandName
            cell.lblShoeName.text = SellerOrderModel.productName
            cell.lblSize.text = SellerOrderModel.sizeName
            cell.lblColor.backgroundColor = UIColor.init(hexFromString: SellerOrderModel.colorCode!)
            cell.lblBidprice.text = "\("$")\(SellerOrderModel.bidPrice!)"
            cell.lblOrderStatus.text = SellerOrderModel.orderStatus
            
            return cell
        }
        
    }
    
//        return UITableViewCell()
//    }
//
}

