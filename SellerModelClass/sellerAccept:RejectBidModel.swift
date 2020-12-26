//
//  sellerAccept:RejectBidModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 11/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct sellerAcceptRejectBidModel:Encodable {
    let bidStatus: String
    let bidRef: String
    
}

struct sellerAcceptRejectBidModelResponse:Codable {
    let status: String
    let msg: String
    
}
