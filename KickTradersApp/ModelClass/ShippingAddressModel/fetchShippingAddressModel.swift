//
//  fetchShippingAddressModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct fetchingShippingAddrssModel:Encodable {
    let buyerRef: String
}

struct fetchingShippingAddrssModelReponse:Codable {
    let status: String?
    let msg: String?
    let address : [Address]?

    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case address = "address"
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        address = try values.decodeIfPresent([Address].self, forKey: .address)
    }
}

// MARK: - Address
struct Address : Codable {
    let id : String?
    let addressRef : String?
    let buyerRef : String?
    let deliveredTo : String?
    let mobile : String?
    let address : String?
    let city : String?
    let state : String?
    let pin : String?
    let is_default : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case addressRef = "addressRef"
        case buyerRef = "buyerRef"
        case deliveredTo = "deliveredTo"
        case mobile = "mobile"
        case address = "address"
        case city = "city"
        case state = "state"
        case pin = "pin"
        case is_default = "is_default"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        addressRef = try values.decodeIfPresent(String.self, forKey: .addressRef)
        buyerRef = try values.decodeIfPresent(String.self, forKey: .buyerRef)
        deliveredTo = try values.decodeIfPresent(String.self, forKey: .deliveredTo)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        pin = try values.decodeIfPresent(String.self, forKey: .pin)
        is_default = try values.decodeIfPresent(String.self, forKey: .is_default)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}




