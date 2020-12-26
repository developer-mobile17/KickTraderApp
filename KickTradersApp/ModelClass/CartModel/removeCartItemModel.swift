//
//  removeCartItemModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 24/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct removeCartItemModel: Encodable {
    let buyerRef: String
    let cartRef: String
}

struct removeCartItemResponse:Codable{
    let status: String
    let msg: String
}
