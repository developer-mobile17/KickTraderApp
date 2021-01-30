//
//  ContactUsModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct ContactUs_Request:Encodable {
    let userRef:String
    let message:String


}

struct ContactUs_Response:Codable {
    let status : String?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
