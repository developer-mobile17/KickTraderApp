//
//  updateUserInfoModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 25/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct updateUserInfoModel:Encodable {
    let Full_Name: String
    let Email: String
    let Mobile: String
    let gender: String
    let profile_image: String
    let open_time: String
    let close_time: String
    let shop_description: String
    let address: String
    let userRef: String
   
}

struct updateUserInfoModelResponse:Codable{
    let status: String
    let msg: String
}
