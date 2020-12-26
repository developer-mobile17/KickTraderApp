//
//  SellerSignUpVerficationModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 19/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct SellerSignUpVerfication: Encodable {
    let Code: String
    let mobile: String
}

struct SellerSignUpVerficationResponse: Codable {
    
    let status, msg: String
    enum CodingKeys: String, CodingKey {
        case status, msg
    }
}


