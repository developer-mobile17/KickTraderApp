//
//  addShippingAddressModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct addShippingAddressModel:Encodable {
    let buyerRef: String
    let deliveredTo: String
    let mobile: String
    let address: String
    let city: String
    let state: String
    let pin: String
   
}


struct addShippingAddressModelReponse: Codable {
    let status: String?
    let msg: String?
  

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
