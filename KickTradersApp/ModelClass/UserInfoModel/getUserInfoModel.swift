//
//  getUserInfoModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 25/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct getUserInfoModel:Encodable {
    let Value: String
    let Key: String
}


// MARK: - getUserInfoModelResponse
struct getUserInfoModelResponse: Codable {
    let status : String?
    let msg : String?
    let userInfo : UserInfo?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case userInfo = "UserInfo"
    }
}


// MARK: - UserInfo
struct UserInfo: Codable {
    let id : String?
    let userRef : String?
    let full_Name : String?
    let appleId : String?
    let email : String?
    let mobile : String?
    let pwd : String?
    let role : String?
    let address : String?
    let gender : String?
    let profile_Image : String?
    let open_time : String?
    let close_time : String?
    let shop_description : String?
    let is_Active : String?
    let device_Token : String?
    let mobileType : String?
    let notification : String?
    let lognStatus : String?
    let location : String?
    let validation_Code : String?
    let createdDtm : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userRef = "userRef"
        case full_Name = "Full_Name"
        case appleId = "AppleId"
        case email = "Email"
        case mobile = "Mobile"
        case pwd = "pwd"
        case role = "Role"
        case address = "address"
        case gender = "gender"
        case profile_Image = "Profile_Image"
        case open_time = "open_time"
        case close_time = "close_time"
        case shop_description = "shop_description"
        case is_Active = "Is_Active"
        case device_Token = "Device_Token"
        case mobileType = "MobileType"
        case notification = "notification"
        case lognStatus = "lognStatus"
        case location = "location"
        case validation_Code = "Validation_Code"
        case createdDtm = "createdDtm"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        userRef = try values.decodeIfPresent(String.self, forKey: .userRef)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        appleId = try values.decodeIfPresent(String.self, forKey: .appleId)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        pwd = try values.decodeIfPresent(String.self, forKey: .pwd)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        shop_description = try values.decodeIfPresent(String.self, forKey: .shop_description)
        is_Active = try values.decodeIfPresent(String.self, forKey: .is_Active)
        device_Token = try values.decodeIfPresent(String.self, forKey: .device_Token)
        mobileType = try values.decodeIfPresent(String.self, forKey: .mobileType)
        notification = try values.decodeIfPresent(String.self, forKey: .notification)
        lognStatus = try values.decodeIfPresent(String.self, forKey: .lognStatus)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        validation_Code = try values.decodeIfPresent(String.self, forKey: .validation_Code)
        createdDtm = try values.decodeIfPresent(String.self, forKey: .createdDtm)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
