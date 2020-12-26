//
//  sellerGetOtpModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct sellerGetOtp:Encodable {
    let mobile: String
}

struct sellerGetOtpResponse: Codable {
    let status : String?
    let msg : String?
    let otp : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case otp = "otp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        otp = try values.decodeIfPresent(Int.self, forKey: .otp)
    }

}
