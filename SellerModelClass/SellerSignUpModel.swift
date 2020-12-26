//
//  SellerSignUpModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct sellerSignUpModel: Encodable {
    
    
    let Full_Name:String
    let Email:String
    let Mobile:String
    let Password:String
    let Role:String
    let device_token:String
    let mobileType:String
    
    
   
   
    let gender:String
    let profile_image:String
    let open_time:String
    let close_time:String
    let shop_description:String
    let address:String
    
}

struct sellerSignUpResponse: Codable {
    let status: String
    let msg: String
    let smsResponse: SMSResponse
    let userinfo: UserInfoSignUp
   
    
    enum CodingKeys: String,CodingKey {
        case status
        case msg
        case smsResponse = "sms_response"
        case userinfo = "UserInfo"
       
    }
    
}

// MARK: - SMSResponse
struct SMSResponse: Codable {
    let numbers: String?
    let text: String
}

struct UserInfoSignUp: Codable {
    let Mobile: String?
    let Validation_Code:String?
    
}
