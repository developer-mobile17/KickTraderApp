//
//  NotificationVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet var objTable:UITableView!
    @IBOutlet var vwNoNotification: DesignableView!
    var arrGetNotification = [ChatData]()
    var strBaseUrl_Notification:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwNoNotification.isHidden = true
        self.getNotification()
        
    }
    
    
}


extension NotificationVC
{
    func getNotification(){
        
      //  let getNotificationParam = getNotificationRequestModel(userRef: "7hy2xYA0Aa763")
        
        let getNotificationParam = getNotificationRequestModel(userRef: UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String)
        
        BuyerAPIManager.shareInstance.callingGetNotificationAPI(getNotificationParam: getNotificationParam) { [self] (result) in
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                let msg = (json as! getNotificationResponse).msg!
                print(msg)
                self.arrGetNotification = (json as! getNotificationResponse).chatData!
                if self.arrGetNotification.count == 0 {
                    self.vwNoNotification.isHidden = false
                    print("No New Notification received")
                }
                else {
                    self.vwNoNotification.isHidden = true
                    self.objTable?.reloadData()
                }
               
                
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
    
}


extension NotificationVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGetNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as!NotificationCell
        
        let getNotificationData = arrGetNotification[indexPath.row]
        let imgURL = URL(string:"\(PRODUCT_COVER_IMAGE)\(getNotificationData.productCoverImage!)")
        cell.imgShoes.kf.setImage(with: imgURL)
        cell.lblShoeBrand.text = getNotificationData.brandName
        cell.lblShoeName.text = getNotificationData.productName
        cell.lblNotification_text.text = getNotificationData.notificationText
        
        return cell
    }
    
    
}
