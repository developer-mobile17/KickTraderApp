//
//  loginModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct loginModel : Encodable {
    let Password: String
    let Role: String
    let FieldType: String
    let Email: String
    let deviceToken: String
    let mobileType: String
}

struct loginModelResponse:Codable {
    
    let status : String?
    let msg : String?
    let varification : String?
    let base_url : String?
    let userInfo : UseRInfo?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case varification = "varification"
        case base_url = "base_url"
        case userInfo = "UserInfo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        varification = try values.decodeIfPresent(String.self, forKey: .varification)
        base_url = try values.decodeIfPresent(String.self, forKey: .base_url)
        userInfo = try values.decodeIfPresent(UseRInfo.self, forKey: .userInfo)
    }

}

struct UseRInfo : Codable {
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
    let deviceToken : String?
    let mobileType : String?
    let notification : String?
    let loginStatus : String?
    let location : String?
    let validation_Code : String?
    let createdDtm : String?

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
        case deviceToken = "deviceToken"
        case mobileType = "mobileType"
        case notification = "notification"
        case loginStatus = "loginStatus"
        case location = "location"
        case validation_Code = "Validation_Code"
        case createdDtm = "createdDtm"
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
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        mobileType = try values.decodeIfPresent(String.self, forKey: .mobileType)
        notification = try values.decodeIfPresent(String.self, forKey: .notification)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        validation_Code = try values.decodeIfPresent(String.self, forKey: .validation_Code)
        createdDtm = try values.decodeIfPresent(String.self, forKey: .createdDtm)
    }

}

