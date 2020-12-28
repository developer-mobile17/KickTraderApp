//
//  unboxingVideoModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 28/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct unboxingVideoModel : Codable {
    let status : String?
    let msg : String?
    let base_url : String?
    let unboxingResult : [UnboxingResult]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case base_url = "base_url"
        case unboxingResult = "unboxingResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        base_url = try values.decodeIfPresent(String.self, forKey: .base_url)
        unboxingResult = try values.decodeIfPresent([UnboxingResult].self, forKey: .unboxingResult)
    }

}

struct UnboxingResult : Codable {
    let id : String?
    let unboxingRef : String?
    let unboxingVideo : String?
    let created_at : String?
    let orderNumber : String?
    let productName : String?
    let productPrice : String?
    let productCoverImage : String?
    let productVideo : String?
    let brandName : String?
    let colorName : String?
    let colorCode : String?
    let averageRating : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case unboxingRef = "unboxingRef"
        case unboxingVideo = "unboxingVideo"
        case created_at = "created_at"
        case orderNumber = "orderNumber"
        case productName = "productName"
        case productPrice = "productPrice"
        case productCoverImage = "productCoverImage"
        case productVideo = "productVideo"
        case brandName = "brandName"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case averageRating = "AverageRating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        unboxingRef = try values.decodeIfPresent(String.self, forKey: .unboxingRef)
        unboxingVideo = try values.decodeIfPresent(String.self, forKey: .unboxingVideo)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        productVideo = try values.decodeIfPresent(String.self, forKey: .productVideo)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        averageRating = try values.decodeIfPresent(String.self, forKey: .averageRating)
    }

}

