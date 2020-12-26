//
//  PlaceABidModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 27/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct PlaceABidModel: Encodable {
    
    let productRef: String
    let coloToProductRef: String
    let sizeToColorRef: String
    let buyerRef: String
    let bidPrice: String
    
}

struct PlaceABidModelResponse: Codable {
    let status: String
    let msg: String
}
