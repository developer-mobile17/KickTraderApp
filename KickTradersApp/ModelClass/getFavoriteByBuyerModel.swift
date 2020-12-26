//
//  getFavoriteByBuyerModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 03/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct getFavoriteByBuyerModel: Encodable {
    
    let buyerRef : String
}
struct getFavoriteByBuyerModelResponse : Codable {
    let status : String?
    let msg : String?
    let favoriteItems : [FavoriteItems]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case favoriteItems = "favoriteItems"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        favoriteItems = try values.decodeIfPresent([FavoriteItems].self, forKey: .favoriteItems)
    }

}

struct FavoriteItems : Codable {
    let id : String?
    let buyerRef : String?
    let productRef : String?
    let productName : String?
    let productPrice : String?
    let productCoverImage : String?
    let brandName : String?
    let averageRating : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case buyerRef = "buyerRef"
        case productRef = "productRef"
        case productName = "productName"
        case productPrice = "productPrice"
        case productCoverImage = "productCoverImage"
        case brandName = "brandName"
        case averageRating = "AverageRating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        buyerRef = try values.decodeIfPresent(String.self, forKey: .buyerRef)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        averageRating = try values.decodeIfPresent(String.self, forKey: .averageRating)
    }

}
