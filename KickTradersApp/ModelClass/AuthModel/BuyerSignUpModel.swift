//
//  BuyerSignUpModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct BuyerSignUpModel: Encodable {
    
    
    let Full_Name:String
    let Email:String
    let Mobile:String
    let Password:String
    let Role:String
    let gender:String
    let address:String
    let device_token:String
    let profile_image:String
   
    
}

struct BuyerSignUpModelResponse: Codable {
    let status: String
    let msg: String
    let smsResponse: SMSREsponse
    let userinfo: UserInfoBuyerSignUp
   
    
    enum CodingKeys: String,CodingKey {
        case status
        case msg
        case smsResponse = "sms_response"
        case userinfo = "UserInfo"
       
    }
    
}

// MARK: - SMSResponse
struct SMSREsponse: Codable {
    let numbers: String?
    let text: String
}

struct UserInfoBuyerSignUp: Codable {
    let Mobile: String?
    let Validation_Code:String?
    
}



