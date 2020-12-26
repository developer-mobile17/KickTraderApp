//
//  SellerRemoveColorModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct SellerRemoveColorModel:Encodable {
    let productRef:String
    let colorRef:String
}

struct SellerRemoveColorModelResponse:Codable {
    let status:String
    let msg:String
}
