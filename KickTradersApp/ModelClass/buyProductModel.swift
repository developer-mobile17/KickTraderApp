//
//  buyProductModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 27/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct buyProductModel: Encodable {
    
    let cartRef: String
    let buyerRef: String
    let addressRef: String
    
}

struct buyProductModelResponse: Codable {
    let status: String
    let msg: String
}
