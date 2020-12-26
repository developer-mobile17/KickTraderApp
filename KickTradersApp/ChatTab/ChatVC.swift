//
//  ChatVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 17/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

struct ChatList {
    let name :String
    let message: String
    let time: String
}

class ChatVC: UIViewController {
    
    var arrMessage = [ChatList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrMessage = [ChatList(name: "Jumior Magana", message: "Hello How are you", time: "6 mon, 6:23pm"),
                      ChatList(name: "Jhon Snow", message: "Hi Vikas, How are you ", time: "7 tue, 5:00p,")
        ]
        
        
    }
    
}


extension ChatVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatVCCell", for: indexPath) as! ChatVCCell
        
        let ChatListModel = arrMessage[indexPath.row]
        cell.lblName.text = ChatListModel.name
        cell.lblMessage.text = ChatListModel.message
        cell.lblDate.text = ChatListModel.time
        
        return cell
        
    }
    
    
}
