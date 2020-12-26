//
//  addReviewModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 07/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct addReviewModel:Encodable {
    let fromRef : String
    let toRef : String
    let rating : String
    let comment : String
}

struct addReviewModelResponse: Codable {
    let status : String
    let msg: String
}
