//
//  ChatDetailVC.swift
//  KickTradersApp
//
//  Created by anil kumar on 14/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import UIKit
import Kingfisher

class CellIds {

    static let senderCellId = "SenderChatCell"

    static let receiverCellId = "ReceiverChatCell"
}


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

        let strURL = "\(PROFILE_IMAGE)\(String(describing: receiverPhoto!))"

        if let receiverImgURL = URL(string: strURL) {
        print(receiverImgURL)

        self.imgReceiver.kf.setImage(with:receiverImgURL)

        }



//        //TODO:- Register Table Cell Here.
//        let senderXib = UINib(nibName: "SenderChatCell", bundle: nil)
//        self.objChatTable.register(senderXib, forCellReuseIdentifier: CellIds.senderCellId)
//        let receiverXib = UINib(nibName: "ReceiverChatCell", bundle: nil)
//        self.objChatTable.register(receiverXib, forCellReuseIdentifier:CellIds.receiverCellId)


        self.objChatTable.edges([.left, .right], to: self.view, offset: .zero)

        self.objChatTable.dataSource = self
        self.objChatTable.delegate = self
        self.objChatTable.register(CustomTableViewCell.self, forCellReuseIdentifier: CellIds.receiverCellId)
        self.objChatTable.register(CustomTableViewCell.self, forCellReuseIdentifier: CellIds.senderCellId)

        objTxvSendMessage.delegate = self
        objTxvSendMessage.text = "Write your message here..."

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
              //  print(json!)
                ProgressHUD.dismiss()

                self.arrChatHistory = (json as! ChatHistoryModelResponse).chatHistory!
               // print(self.arrChatHistory)

                DispatchQueue.main.async {
                    self.objChatTable.reloadData()
                }

            case.failure(let err):
                ProgressHUD.dismiss()
                print(err.localizedDescription)
            }

        }

    }

}

extension ChatDetailVC : UITableViewDataSource{



        func numberOfSections(in tableView: UITableView) -> Int {
            return arrChatHistory.count
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let ChatHistoryModel = arrChatHistory[indexPath.section]


                    //TODO:-String to Date Convert
                    let dateString =  ChatHistoryModel.created_at!
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let s = dateFormatter.date(from: dateString)


                    //TODO:- CONVERT FROM NSDate to String

                    let date2Formatter = DateFormatter()
                    date2Formatter.dateFormat = "MMM d, h:mm a"
                    let date2String = date2Formatter.string(from:s! as Date)
                    print(date2String)
                    //cell.lblDate.text = date2String


            let userType = ChatHistoryModel.userType

            if userType == "Buyer" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.senderCellId, for: indexPath) as? CustomTableViewCell {
                    cell.selectionStyle = .none
                    cell.textView.text = ChatHistoryModel.message
                    cell.bottomLabel.text = date2String
                    //cell.showTopLabel = true
                    return cell
                }
            }
            else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.receiverCellId, for: indexPath) as? CustomTableViewCell {
                    cell.selectionStyle = .none
                    cell.textView.text = ChatHistoryModel.message
                    cell.bottomLabel.text = date2String


                    let imgURL = URL(string:"\(chatImgBase_Url)\(ChatHistoryModel.chatImage!)")!
                    print(imgURL)
                    cell.imgVW.kf.setImage(with: imgURL)
                    return cell
                }
            }
            return UITableViewCell()
        }

    


//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return arrChatHistory.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell_Sender = tableView.dequeueReusableCell(withIdentifier:CellIds.senderCellId) as! SenderChatCell
//        let cell_Receiver = tableView.dequeueReusableCell(withIdentifier:CellIds.receiverCellId) as! ReceiverChatCell
//
//        let ChatHistoryModel = arrChatHistory[indexPath.row]
//
//
//
//        //TODO:-String to Date Convert
//        let dateString =  ChatHistoryModel.created_at!
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let s = dateFormatter.date(from: dateString)
//
//
//        //TODO:- CONVERT FROM NSDate to String
//
//        let date2Formatter = DateFormatter()
//        date2Formatter.dateFormat = "MMM d, h:mm a"
//        let date2String = date2Formatter.string(from:s! as Date)
//        print(date2String)
//        //cell.lblDate.text = date2String
//
//
//
//
//        let userType = ChatHistoryModel.userType
//        if userType == "Buyer" {
//            cell_Sender.textView.text = ChatHistoryModel.message!
//            cell_Sender.bottomLabel.text = date2String
//            cell_Sender.setupSendersCell()
//
//
//
//          return cell_Sender
//        }
//
//        else {
//            print(ChatHistoryModel.message!)
//            cell_Receiver.textViewR.text = ChatHistoryModel.message!
//            cell_Receiver.bottomLabelR.text = date2String
//            cell_Receiver.setupReceiverCell()
//
//            let imgURL = URL(string:"\(chatImgBase_Url)\(ChatHistoryModel.chatImage!)")
//            cell_Receiver.imgReceiverChat.kf.setImage(with: imgURL)
//
//
//
//            return cell_Receiver
//        }
//
//
//
//    }

}



extension ChatDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



//TODO:- Send Message Using API
extension ChatDetailVC {
    func callingSendMessageAPI() {

        let senderRef = UserDefaults.standard.value(forKey: "DefaultsbuyerRef") as! String
        let sendChatMessageParam = ChatSendMessageRequest(senderRef: senderRef, receiverRef: receiverRefPass, messageText: objTxvSendMessage.text, chatImage: "", chatRef: chatRefPass, orderNumber:orderNoPass, senderRole:"Buyer")
      //  print(sendChatMessageParam)

            //ChatHistoryModelRequest(chatRef: "l0aaq2I214N62", userRef: "cJte0ux3iNeLq")
        ProgressHUD.show(interaction: false)

        BuyerAPIManager.shareInstance.CallingSendMessage_API(sendMessageParam: sendChatMessageParam) { (result) in


            switch result {
            case.success(let json):
                //(json!)
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


