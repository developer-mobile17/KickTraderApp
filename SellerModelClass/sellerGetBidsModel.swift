//
//  sellerGetBidsModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 30/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct sellerGetBidsModel: Encodable {
    let sellerRef: String
}

struct sellerGetBidsModelResponse : Codable {
    let status : String?
    let msg : String?
    let bidItem : [BidItem]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case bidItem = "bidItem"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        bidItem = try values.decodeIfPresent([BidItem].self, forKey: .bidItem)
    }

}

struct BidItem : Codable {
    let id : String?
    let cartRef : String?
    let buyerRef : String?
    let productRef : String?
    let coloToProductRef : String?
    let sizeToColorRef : String?
    let bidPrice : String?
    let status : String?
    let productName : String?
    let category_Name : String?
    let productSubCategory : String?
    let productPrice : String?
    let brandName : String?
    let brandImage : String?
    let productDescription : String?
    let productCoverImage : String?
    let productVideo : String?
    let colorName : String?
    let colorCode : String?
    let sizeName : String?
    let bidArray : [BidArray]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cartRef = "cartRef"
        case buyerRef = "buyerRef"
        case productRef = "productRef"
        case coloToProductRef = "coloToProductRef"
        case sizeToColorRef = "sizeToColorRef"
        case bidPrice = "bidPrice"
        case status = "status"
        case productName = "productName"
        case category_Name = "category_Name"
        case productSubCategory = "productSubCategory"
        case productPrice = "productPrice"
        case brandName = "brandName"
        case brandImage = "brandImage"
        case productDescription = "productDescription"
        case productCoverImage = "productCoverImage"
        case productVideo = "productVideo"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case sizeName = "sizeName"
        case bidArray = "bidArray"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        cartRef = try values.decodeIfPresent(String.self, forKey: .cartRef)
        buyerRef = try values.decodeIfPresent(String.self, forKey: .buyerRef)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        coloToProductRef = try values.decodeIfPresent(String.self, forKey: .coloToProductRef)
        sizeToColorRef = try values.decodeIfPresent(String.self, forKey: .sizeToColorRef)
        bidPrice = try values.decodeIfPresent(String.self, forKey: .bidPrice)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        category_Name = try values.decodeIfPresent(String.self, forKey: .category_Name)
        productSubCategory = try values.decodeIfPresent(String.self, forKey: .productSubCategory)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        brandImage = try values.decodeIfPresent(String.self, forKey: .brandImage)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        productVideo = try values.decodeIfPresent(String.self, forKey: .productVideo)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        bidArray = try values.decodeIfPresent([BidArray].self, forKey: .bidArray)
    }

}


struct BidArray : Codable {
    let id : String?
    let cartRef : String?
    let buyerRef : String?
    let productRef : String?
    let coloToProductRef : String?
    let sizeToColorRef : String?
    let bidPrice : String?
    let status : String?
    let full_Name : String?
    let profile_Image : String?
    let averageRating : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cartRef = "cartRef"
        case buyerRef = "buyerRef"
        case productRef = "productRef"
        case coloToProductRef = "coloToProductRef"
        case sizeToColorRef = "sizeToColorRef"
        case bidPrice = "bidPrice"
        case status = "status"
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
        case averageRating = "AverageRating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        cartRef = try values.decodeIfPresent(String.self, forKey: .cartRef)
        buyerRef = try values.decodeIfPresent(String.self, forKey: .buyerRef)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        coloToProductRef = try values.decodeIfPresent(String.self, forKey: .coloToProductRef)
        sizeToColorRef = try values.decodeIfPresent(String.self, forKey: .sizeToColorRef)
        bidPrice = try values.decodeIfPresent(String.self, forKey: .bidPrice)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
        averageRating = try values.decodeIfPresent(String.self, forKey: .averageRating)
    }

}
