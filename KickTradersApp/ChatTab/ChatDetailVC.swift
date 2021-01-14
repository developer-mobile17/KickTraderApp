//
//  ChatDetailVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 14/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit
import MessageKit


class ChatDetailVC:UIViewController{
    var arrChatHistory = [ChatHistory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callingGetChatListAPI()
    }
}


//TODO:- Get Chat His  API
extension ChatDetailVC {
    func callingGetChatListAPI() {

        let getChatHistoryParam = ChatHistoryModelRequest(chatRef: "l0aaq2I214N62", userRef: "cJte0ux3iNeLq")
        ProgressHUD.show(interaction: false)

        BuyerAPIManager.shareInstance.CallingGetChat_HistoryAPI(getChat_HistoryParam: getChatHistoryParam) { (result) in


            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()

                self.arrChatHistory = (json as! ChatHistoryModelResponse).chatHistory!
                print(self.arrChatHistory)

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }

}


