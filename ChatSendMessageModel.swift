//
//  ChatSendMessageRequestModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct ChatSendMessageRequest:Encodable {
    let senderRef:String
    let receiverRef:String
    let messageText:String
    let chatImage:String
    let chatRef:String
    let orderNumber:String
    let senderRole:String
}


struct ChatSendMessageResponse:Decodable {
    let status:String
    let msg:String

}


