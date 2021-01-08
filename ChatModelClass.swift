//
//  ChatModelClass.swift
//  KickTradersApp
//
//  Created by anil kumar on 07/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation

struct getChatListRequest:Encodable {
    let userRef :String
    let userType :String
        
}

struct getChatListResponse: Codable {
    let status : String?
    let msg : String?
    let base_url : String?
    let chatData : [ChatDataList]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case base_url = "base_url"
        case chatData = "chatData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        base_url = try values.decodeIfPresent(String.self, forKey: .base_url)
        chatData = try values.decodeIfPresent([ChatDataList].self, forKey: .chatData)
    }

}

struct ChatDataList : Codable {
    let id : String?
    let chatRef : String?
    let orderNumber : String?
    let userRef : String?
    let receiverRef : String?
    let lastMessage : String?
    let seenId : String?
    let isSeen : String?
    let create_at : String?
    let update_at : String?
    let full_Name : String?
    let profile_Image : String?
    let orderStatus : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case chatRef = "chatRef"
        case orderNumber = "orderNumber"
        case userRef = "userRef"
        case receiverRef = "receiverRef"
        case lastMessage = "lastMessage"
        case seenId = "seenId"
        case isSeen = "isSeen"
        case create_at = "create_at"
        case update_at = "update_at"
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
        case orderStatus = "orderStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        chatRef = try values.decodeIfPresent(String.self, forKey: .chatRef)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
        userRef = try values.decodeIfPresent(String.self, forKey: .userRef)
        receiverRef = try values.decodeIfPresent(String.self, forKey: .receiverRef)
        lastMessage = try values.decodeIfPresent(String.self, forKey: .lastMessage)
        seenId = try values.decodeIfPresent(String.self, forKey: .seenId)
        isSeen = try values.decodeIfPresent(String.self, forKey: .isSeen)
        create_at = try values.decodeIfPresent(String.self, forKey: .create_at)
        update_at = try values.decodeIfPresent(String.self, forKey: .update_at)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
    }

}

