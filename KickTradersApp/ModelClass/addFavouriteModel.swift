//
//  addFavouriteModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct addFavoriteModel: Encodable {
    let buyerRef : String
    let productRef : String
    let action : String
}

struct addFavoriteModelResponse: Codable {
    let status : String
    let msg : String
}
