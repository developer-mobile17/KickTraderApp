//
//  AddToCartItemModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 25/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct addToCartModel: Encodable{
    let buyerRef: String
    let productRef: String
    let coloToProductRef: String
    let sizeToColorRef: String
        
}

struct addToCartModelResponse: Codable {
    let status: String
    let msg: String
}
