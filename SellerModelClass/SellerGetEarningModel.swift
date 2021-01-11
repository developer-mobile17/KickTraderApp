//
//  SellerGetEarningModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 08/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct SellerGetEarningRequest:Encodable {
    
    let sellerRef:String
    
}

struct SellerGetEarningResponse : Codable {
    let status : String?
    let msg : String?
    let earningDetails : EarningDetails?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case earningDetails = "earningDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        earningDetails = try values.decodeIfPresent(EarningDetails.self, forKey: .earningDetails)
    }

}



struct EarningDetails : Codable {
    let personalBalance : Int?
    let lastMonthEarnings : String?
    let avgSellingPrice : String?
    let activeAppointment : String?
    let activeAppointmentCount : String?
    let pendingClearance : Int?
    let cancelledAppointment : Int?
    let cancelOrderCount : String?
    let totalOrders : String?
    let earnedToday : Int?
    let inProgress : String?
    let orderQueue : Int?
    let withdraw : Int?
    let sellerDetail : SellerDetailHome?

    enum CodingKeys: String, CodingKey {

        case personalBalance = "personalBalance"
        case lastMonthEarnings = "lastMonthEarnings"
        case avgSellingPrice = "avgSellingPrice"
        case activeAppointment = "activeAppointment"
        case activeAppointmentCount = "activeAppointmentCount"
        case pendingClearance = "pendingClearance"
        case cancelledAppointment = "cancelledAppointment"
        case cancelOrderCount = "cancelOrderCount"
        case totalOrders = "totalOrders"
        case earnedToday = "earnedToday"
        case inProgress = "inProgress"
        case orderQueue = "orderQueue"
        case withdraw = "withdraw"
        case sellerDetail = "sellerDetail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        personalBalance = try values.decodeIfPresent(Int.self, forKey: .personalBalance)
        lastMonthEarnings = try values.decodeIfPresent(String.self, forKey: .lastMonthEarnings)
        avgSellingPrice = try values.decodeIfPresent(String.self, forKey: .avgSellingPrice)
        activeAppointment = try values.decodeIfPresent(String.self, forKey: .activeAppointment)
        activeAppointmentCount = try values.decodeIfPresent(String.self, forKey: .activeAppointmentCount)
        pendingClearance = try values.decodeIfPresent(Int.self, forKey: .pendingClearance)
        cancelledAppointment = try values.decodeIfPresent(Int.self, forKey: .cancelledAppointment)
        cancelOrderCount = try values.decodeIfPresent(String.self, forKey: .cancelOrderCount)
        totalOrders = try values.decodeIfPresent(String.self, forKey: .totalOrders)
        earnedToday = try values.decodeIfPresent(Int.self, forKey: .earnedToday)
        inProgress = try values.decodeIfPresent(String.self, forKey: .inProgress)
        orderQueue = try values.decodeIfPresent(Int.self, forKey: .orderQueue)
        withdraw = try values.decodeIfPresent(Int.self, forKey: .withdraw)
        sellerDetail = try values.decodeIfPresent(SellerDetailHome.self, forKey: .sellerDetail)
    }

}


struct SellerDetailHome : Codable {
    let id : String?
    let userRef : String?
    let full_Name : String?
    let appleId : String?
    let email : String?
    let mobile : String?
    let password : String?
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
    let disputeCount : String?
    let isSuspend : String?
    let suspendTill : String?
    let createdDtm : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userRef = "userRef"
        case full_Name = "Full_Name"
        case appleId = "AppleId"
        case email = "Email"
        case mobile = "Mobile"
        case password = "Password"
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
        case disputeCount = "disputeCount"
        case isSuspend = "isSuspend"
        case suspendTill = "suspendTill"
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
        password = try values.decodeIfPresent(String.self, forKey: .password)
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
        disputeCount = try values.decodeIfPresent(String.self, forKey: .disputeCount)
        isSuspend = try values.decodeIfPresent(String.self, forKey: .isSuspend)
        suspendTill = try values.decodeIfPresent(String.self, forKey: .suspendTill)
        createdDtm = try values.decodeIfPresent(String.self, forKey: .createdDtm)
    }

}
