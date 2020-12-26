//
//  cancelOrderModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 08/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct cancelOrderModel : Encodable {
    let orderNumber: String
}


struct cancelOrderModelResponse : Codable {
    let status: String
    let msg: String
}
