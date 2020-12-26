//
//  removeAddressModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct removeAddressModel:Encodable {
    let addressRef: String
}


struct removeAddressModelResponse:Codable {
    let status: String
    let msg: String
}

