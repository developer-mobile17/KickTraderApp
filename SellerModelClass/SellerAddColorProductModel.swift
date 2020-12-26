//
//  SellerAddColorProductModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 10/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct SellerAddColorProductModel:Encodable {
    let productRef:String
    let colorRef:String
    let sizeList : [String]
    let imageList : [String]
}

struct SellerAddColorProductModelResponse:Codable {
    
    let status:String
    let msg:String
        
}
