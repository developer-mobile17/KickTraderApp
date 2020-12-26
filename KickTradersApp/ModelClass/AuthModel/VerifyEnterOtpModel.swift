//
//  VerifyEnterOtpModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 22/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct EnterOtpModel: Encodable {
    let Code: String
    let mobile: String
}

struct EnterOtpModelResponse: Codable {
    
    let status, msg: String
    enum CodingKeys: String, CodingKey {
        case status, msg
    }
}
