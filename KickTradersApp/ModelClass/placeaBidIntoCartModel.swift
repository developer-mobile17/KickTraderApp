//
//  placeaBidIntoCartModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 27/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct placeABidInToCartModel: Encodable {
    
    let cartRef: String
    let bidPrice: String
    
}

struct placeABidInToCartModelResponse: Codable {
    let status: String
    let msg: String
}
