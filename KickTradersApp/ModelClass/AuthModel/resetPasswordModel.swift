//
//  resetPasswordModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct resetPasswordModel : Encodable {
    let Mobile : String!
    let OTP : String!
    let Password : String!
}

struct resetPasswordModelResponse : Codable {
    let status : String!
    let msg : String!
    
}
