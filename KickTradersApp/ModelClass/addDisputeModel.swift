//
//  addDisputeModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 21/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct addDisputeRequest: Encodable {
    let disputeBy:String
    let disputeTo:String
    let disputeOn:String
    let disputeComment:String
}

struct addDisputeResponse:Codable {
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
