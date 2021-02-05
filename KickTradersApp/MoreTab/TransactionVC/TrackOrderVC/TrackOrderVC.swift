//
//  TrackOrderVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit

class TrackOrderVC: UIViewController {

    @IBOutlet var objTbl:UITableView!
    var OrderNoPass:String?
    var arrShippingStaus = [TrackingHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        self.callingGetShippingStatusAPI()

    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//TODO:- get Buyer Orders  API
extension TrackOrderVC {
    func callingGetShippingStatusAPI() {

        ProgressHUD.show("Please wait.",  interaction: false)
        OrderNoPass = UserDefaults.standard.value(forKey: "DefaultorderNumber") as? String

        let getShippingParam = getShippingStatusRequest(orderNumber:OrderNoPass!)
        BuyerAPIManager.shareInstance.CallingGetShippingStatus_API(getShippingStatusParam: getShippingParam) { [self] (result) in

            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()

                self.arrShippingStaus = (json as! getShippingStatusResponse).trackingHistory!

                self.objTbl?.reloadData()
                let msg = (json as! getShippingStatusResponse).msg!
                print(msg)

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }

}





extension TrackOrderVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrShippingStaus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackOrderCell", for: indexPath) as! TrackOrderCell

        let shippingStatusData = arrShippingStaus[indexPath.row]
        cell.lblOrderStatus.text = shippingStatusData.orderStatus

        //TODO:- Image of Order status Set here
         let orderStatus = shippingStatusData.status
        if orderStatus == "completed" {

          //  let image : UIImage = UIImage(named: "Rectangle 1")!

            let image : UIImage = UIImage(systemName: "checkmark.circle.fill")!

            cell.imgStatus.image = image

        }
        if orderStatus == "active" {
            let image : UIImage = UIImage(systemName: "smallcircle.fill.circle")!
            cell.imgStatus.image = image

        }

        if  orderStatus == "inactive" {
            let image : UIImage = UIImage(systemName: "circle")!
            cell.imgStatus.image = image

        }




        //TODO:- Date conversion logic here
        let getDateFromAPI = shippingStatusData.dateTime
        print("Get date string from API",getDateFromAPI!)


        //TODO:-String to Date Convert
        let dateString =  shippingStatusData.dateTime!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let s = dateFormatter.date(from: dateString) else { return
            UITableViewCell()
        }

        //TODO:- CONVERT FROM NSDate to String

        let date2Formatter = DateFormatter()
        date2Formatter.dateFormat = "MMM d, h:mm a"
        let date2String = date2Formatter.string(from:s)
        cell.lblTime.text = date2String
        return cell
    }


}
