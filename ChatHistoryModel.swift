//
//  ChatHistoryModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 14/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct ChatHistoryModelRequest:Encodable {
    let chatRef:String
    let userRef:String
}


struct ChatHistoryModelResponse:Codable {
    let status : String?
    let msg : String?
    let url : String?
    let chatHistory : [ChatHistory]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case url = "url"
        case chatHistory = "ChatHistory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        chatHistory = try values.decodeIfPresent([ChatHistory].self, forKey: .chatHistory)
    }

}


struct ChatHistory : Codable {
    let id : String?
    let chatRef : String?
    let orderNumber : String?
    let senderRef : String?
    let receiverRef : String?
    let userType : String?
    let message : String?
    let chatImage : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case chatRef = "chatRef"
        case orderNumber = "orderNumber"
        case senderRef = "senderRef"
        case receiverRef = "receiverRef"
        case userType = "userType"
        case message = "message"
        case chatImage = "chatImage"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        chatRef = try values.decodeIfPresent(String.self, forKey: .chatRef)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
        senderRef = try values.decodeIfPresent(String.self, forKey: .senderRef)
        receiverRef = try values.decodeIfPresent(String.self, forKey: .receiverRef)
        userType = try values.decodeIfPresent(String.self, forKey: .userType)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        chatImage = try values.decodeIfPresent(String.self, forKey: .chatImage)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}
