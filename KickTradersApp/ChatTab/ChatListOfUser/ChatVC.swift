//
//  ChatVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 17/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

class ChatVC: UIViewController{
    @IBOutlet var objTbl : UITableView!
    @IBOutlet var imgUserProfile: UIButton!
    var arrGetChatList = [ChatDataList]()
    var getDate:Date!
    var getProfileImgOfChatUser: URL!
    var strImgURLofloginUser:String!
    override func viewDidLoad() {
        super.viewDidLoad()



        // overrideUserInterfaceStyle is available with iOS 13
            if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        //self.getProfileImg()
        self.callingGetChatListAPI()

        
    }

    @IBAction func actionGoToUserProfile(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileVC else{

            return
        }
        present(vc, animated: true)
    }

    //TODO:-  Get the User Profile
    func getProfileImg (){
        imgUserProfile.layer.cornerRadius = 12
        imgUserProfile.clipsToBounds = true
        
        strImgURLofloginUser = UserDefaults.standard.value(forKey: "Defaultsprofile_Image")! as? String
        if strImgURLofloginUser == nil {
            print("No Profile Img")
        }
        else {
            let imgProfileURL =  URL(string: "\(PROFILE_IMAGE)\(strImgURLofloginUser!)")
            self.imgUserProfile.kf.setImage(with: imgProfileURL, for: .normal)
            
            
            
        }
        
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.getProfileImg()
    }

}


//TODO:- get Buyer Orders  API
extension ChatVC {
    func callingGetChatListAPI() {

        let userRefPass = UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String
        let getChatListParam = getChatListRequest(userRef:userRefPass, userType: "Buyer")
        ProgressHUD.show(interaction: false)
        
        BuyerAPIManager.shareInstance.CallingGetChatListAPI(getChatListParam: getChatListParam) { (result) in
            
            
            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()
                
                self.arrGetChatList = (json as! getChatListResponse).chatData!
                let msg = (json as! getChatListResponse).msg!
                print(msg)
                self.objTbl?.reloadData()
            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }
            
        }
        
    }
    
}

extension ChatVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGetChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatVCCell", for: indexPath) as! ChatVCCell
        
        let ChatListModel = arrGetChatList[indexPath.row]
        
        cell.imgUser.showLoading(color: .systemRed)
        let getDateFromAPI = ChatListModel.create_at!
        print("Get date string from API",getDateFromAPI)


        //TODO:-String to Date Convert
        let dateString =  ChatListModel.create_at!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let s = dateFormatter.date(from: dateString)


        //TODO:- CONVERT FROM NSDate to String

        let date2Formatter = DateFormatter()
        date2Formatter.dateFormat = "MMM d, h:mm a"
        let date2String = date2Formatter.string(from:s! as Date)
        print(date2String)
        cell.lblDate.text = date2String



      
            self.getProfileImgOfChatUser = URL(string:"\(PROFILE_IMAGE)\(ChatListModel.profile_Image!)")
            cell.imgUser.kf.setImage(with: self.getProfileImgOfChatUser)
            cell.imgUser.stopLoading()
            cell.lblUserName.text = ChatListModel.full_Name
            cell.lblMessage.text = ChatListModel.lastMessage
         //   cell.lblDate.text = ChatListModel.create_at
          //
            
      //  }
        
        return cell
        
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatDetails =  self.storyboard?.instantiateViewController(identifier: "ChatDetailVC") as! ChatDetailVC


       // print(arrGetChatList[indexPath.row].sellerRef)
        chatDetails.chatRefPass = arrGetChatList[indexPath.row].chatRef
        chatDetails.receiverRefPass = arrGetChatList[indexPath.row].sellerRef
        chatDetails.orderNoPass = arrGetChatList[indexPath.row].orderNumber
        chatDetails.receiverName = arrGetChatList[indexPath.row].full_Name
        chatDetails.receiverPhoto = arrGetChatList[indexPath.row].profile_Image


        self.navigationController?.pushViewController(chatDetails, animated: true)
    }
            
    
}
