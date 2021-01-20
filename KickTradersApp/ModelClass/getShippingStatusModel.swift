//
//  getShippingStatusModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/01/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct getShippingStatusRequest:Encodable {
    let orderNumber: String
}


struct getShippingStatusResponse:Decodable {
    let status : String?
    let msg : String?
    let trackingHistory : [TrackingHistory]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case trackingHistory = "trackingHistory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        trackingHistory = try values.decodeIfPresent([TrackingHistory].self, forKey: .trackingHistory)
    }

}

struct TrackingHistory : Codable {
    let orderStatus : String?
    let status : String?
    let dateTime : String?

    enum CodingKeys: String, CodingKey {

        case orderStatus = "orderStatus"
        case status = "Status"
        case dateTime = "dateTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime)
    }

}

