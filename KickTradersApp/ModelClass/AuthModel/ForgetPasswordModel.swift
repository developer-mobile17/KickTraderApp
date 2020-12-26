//
//  ForgetPasswordModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct ForgetPasswordModel:Encodable {
    let Email:String
}


struct ForgetPasswordModelResponse:Codable {
    let status:String
    let msg:String
}
