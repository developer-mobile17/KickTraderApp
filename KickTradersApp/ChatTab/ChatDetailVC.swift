//
//  ChatDetailVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 14/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit
import MessageKit
import Kingfisher


class ChatDetailVC:UIViewController,UITextViewDelegate{
    @IBOutlet var lblHeaderTitle: UILabel!
    
    @IBOutlet var imgReceiver: DesignalbeImage!
    @IBOutlet var objChatTable: UITableView!
    @IBOutlet var objTxvSendMessage: UITextView!
    var arrChatHistory = [ChatHistory]()

    var receiverName:String!
    var receiverPhoto:String!
    var chatRefPass:String!
    var receiverRefPass:String!
    var orderNoPass:String!


    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblHeaderTitle.text = receiverName

        let strURL = "\(PROFILE_IMAGE)\(String(describing: receiverPhoto))"
      //  self.imgReceiver.kf.setImage(with:strURL)

        if let receiverImgURL = URL(string: strURL) {
        print(receiverImgURL)
        }



        //TODO:- Register Table Cell Here.
        let senderXib = UINib(nibName: "SenderChatCell", bundle: nil)
        self.objChatTable.register(senderXib, forCellReuseIdentifier: "SenderChatCell")
        let receiverXib = UINib(nibName: "ReceiverChatCell", bundle: nil)
        self.objChatTable.register(receiverXib, forCellReuseIdentifier: "ReceiverChatCell")

        self.objChatTable.dataSource = self
        self.objChatTable.delegate = self

        objTxvSendMessage.delegate = self
        objTxvSendMessage.text = "Write your message here..."
        self.callingGetChatHistoryAPI()


    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func actionAttachPhoto(_ sender: Any) {
    }
    @IBAction func actionSendMessage(_ sender: Any) {
        self.callingSendMessageAPI()
    }

}

//TODO:- Get Chat History  API
extension ChatDetailVC {
    func callingGetChatHistoryAPI() {

        let getChatHistoryParam = ChatHistoryModelRequest(chatRef:chatRefPass, userRef:UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String)
        ProgressHUD.show(interaction: false)

        BuyerAPIManager.shareInstance.CallingGetChat_HistoryAPI(getChat_HistoryParam: getChatHistoryParam) { (result) in


            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()

                self.arrChatHistory = (json as! ChatHistoryModelResponse).chatHistory!
               // print(self.arrChatHistory)
                self.objChatTable.reloadData()

                DispatchQueue.main.async {
                        let indexPath = IndexPath(row: self.arrChatHistory.count-1, section: 0)
                        self.objChatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }

//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    let indexPath = NSIndexPath(forRow: commentArray.count-1, inSection: 0)
//                  tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
//
//                })



            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }

}

extension ChatDetailVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChatHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell_Sender = tableView.dequeueReusableCell(withIdentifier: "SenderChatCell") as! SenderChatCell
        let cell_Receiver = tableView.dequeueReusableCell(withIdentifier: "ReceiverChatCell") as! ReceiverChatCell
        let ChatHistoryModel = arrChatHistory[indexPath.row]


         cell_Sender.setData(arrChatHistory[indexPath.row])
      //  SenderChatCell.setData(arrChatHistory[indexPath.row])

        let userType = ChatHistoryModel.userType
        if userType == "Buyer" {
            cell_Sender.lblSenderTextMessage.text = ChatHistoryModel.message!
            cell_Sender.lblSenderDate.text = ChatHistoryModel.created_at!


          return cell_Sender
        }

        else {
            print(ChatHistoryModel.message!)
            cell_Receiver.lblReceiverTextMessage.text = ChatHistoryModel.message!
            cell_Receiver.lblReceiverDate.text = ChatHistoryModel.created_at!
            return cell_Receiver
        }



    }

}



//TODO:- Send Message Using API
extension ChatDetailVC {
    func callingSendMessageAPI() {

        let senderRef = UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String
        let sendChatMessageParam = ChatSendMessageRequest(senderRef: senderRef, receiverRef: receiverRefPass, messageText: objTxvSendMessage.text, chatImage: "", chatRef: chatRefPass, orderNumber:orderNoPass)
        print(sendChatMessageParam)

            //ChatHistoryModelRequest(chatRef: "l0aaq2I214N62", userRef: "cJte0ux3iNeLq")
        ProgressHUD.show(interaction: false)

        BuyerAPIManager.shareInstance.CallingSendMessage_API(sendMessageParam: sendChatMessageParam) { (result) in


            switch result {
            case.success(let json):
                print(json!)
                ProgressHUD.dismiss()

                let msg = (json as! ChatSendMessageResponse).msg
                print(msg)
                self.objTxvSendMessage.text = ""
                self.callingGetChatHistoryAPI()

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }

}



extension ChatDetailVC  {

    public func textViewDidBeginEditing(_ textView: UITextView) {
        if objTxvSendMessage.text == "Write your message here..." {
            objTxvSendMessage.text = ""
            objTxvSendMessage.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.86)

        }
        objTxvSendMessage.becomeFirstResponder()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {

        if objTxvSendMessage.text == "" {
            objTxvSendMessage.text = "Write your message here..."
            objTxvSendMessage.textColor = UIColor.darkGray
        }
        objTxvSendMessage.resignFirstResponder()
    }
}
