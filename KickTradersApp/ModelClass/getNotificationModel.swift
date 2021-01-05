//
//  getNotificationModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 05/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation

struct getNotificationRequestModel: Encodable {
    let userRef: String
}
struct getNotificationResponse:Codable {
    let status : String?
    let msg : String?
    let base_url : String?
    let chatData : [ChatData]?

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
        chatData = try values.decodeIfPresent([ChatData].self, forKey: .chatData)
    }

}

struct ChatData : Codable {
    let id : String?
    let notificationRef : String?
    let productRef : String?
    let toRef : String?
    let notificationText : String?
    let create_at : String?
    let productName : String?
    let brandName : String?
    let productCoverImage : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case notificationRef = "notificationRef"
        case productRef = "productRef"
        case toRef = "toRef"
        case notificationText = "notificationText"
        case create_at = "create_at"
        case productName = "productName"
        case brandName = "brandName"
        case productCoverImage = "productCoverImage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        notificationRef = try values.decodeIfPresent(String.self, forKey: .notificationRef)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        toRef = try values.decodeIfPresent(String.self, forKey: .toRef)
        notificationText = try values.decodeIfPresent(String.self, forKey: .notificationText)
        create_at = try values.decodeIfPresent(String.self, forKey: .create_at)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
    }

}
