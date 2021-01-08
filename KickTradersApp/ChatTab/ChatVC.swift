//
//  ChatVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 17/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit


class ChatVC: UIViewController {
    @IBOutlet var objTbl : UITableView!
    var arrGetChatList = [ChatDataList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callingGetChatListAPI()
        
    }
    
}


//TODO:- get Buyer Orders  API
extension ChatVC {
    func callingGetChatListAPI() {
        
        let getChatListParam = getChatListRequest(userRef: "cJte0ux3iNeLq", userType: "Buyer")
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

extension ChatVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGetChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatVCCell", for: indexPath) as! ChatVCCell
        
        let ChatListModel = arrGetChatList[indexPath.row]
        
        cell.imgUser.showLoading(color: .systemRed)
        
        DispatchQueue.main.async {
            
            let imgURL = URL(string:"\(PROFILE_IMAGE)\(ChatListModel.profile_Image!)")
            cell.imgUser.kf.setImage(with: imgURL)
            cell.imgUser.stopLoading()
            cell.lblUserName.text = ChatListModel.full_Name
            cell.lblMessage.text = ChatListModel.lastMessage
            cell.lblDate.text = ChatListModel.create_at
            
        }
        
        return cell
        
    }
    
    
}
