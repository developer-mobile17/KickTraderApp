//
//  getCartItemModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 24/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct getCartItemModel:Encodable {
    let buyerRef:String
}

struct getCartModelResponse:Codable {
    let status : String?
    let msg : String?
    let cartItem : [CartItem]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case cartItem = "cartItem"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        cartItem = try values.decodeIfPresent([CartItem].self, forKey: .cartItem)
    }

}

struct CartItem : Codable {
    let cartRef : String?
    let bidPrice : String?
    let status : String?
    let productRef : String?
    let sellerRef : String?
    let productName : String?
    let productCategoryRef : String?
    let category_Name : String?
    let productSubCategory : String?
    let productPrice : String?
    let productBrandRef : String?
    let brandName : String?
    let productDescription : String?
    let productCoverImage : String?
    let productVideo : String?
    let coloToProductRef : String?
    let colorRef : String?
    let colorName : String?
    let colorCode : String?
    let sizeToColorRef : String?
    let sizeRef : String?
    let sizeName : String?

    enum CodingKeys: String, CodingKey {

        case cartRef = "cartRef"
        case bidPrice = "bidPrice"
        case status = "status"
        case productRef = "productRef"
        case sellerRef = "sellerRef"
        case productName = "productName"
        case productCategoryRef = "productCategoryRef"
        case category_Name = "category_Name"
        case productSubCategory = "productSubCategory"
        case productPrice = "productPrice"
        case productBrandRef = "productBrandRef"
        case brandName = "brandName"
        case productDescription = "productDescription"
        case productCoverImage = "productCoverImage"
        case productVideo = "productVideo"
        case coloToProductRef = "coloToProductRef"
        case colorRef = "colorRef"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case sizeToColorRef = "sizeToColorRef"
        case sizeRef = "sizeRef"
        case sizeName = "sizeName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cartRef = try values.decodeIfPresent(String.self, forKey: .cartRef)
        bidPrice = try values.decodeIfPresent(String.self, forKey: .bidPrice)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        sellerRef = try values.decodeIfPresent(String.self, forKey: .sellerRef)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productCategoryRef = try values.decodeIfPresent(String.self, forKey: .productCategoryRef)
        category_Name = try values.decodeIfPresent(String.self, forKey: .category_Name)
        productSubCategory = try values.decodeIfPresent(String.self, forKey: .productSubCategory)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productBrandRef = try values.decodeIfPresent(String.self, forKey: .productBrandRef)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        productVideo = try values.decodeIfPresent(String.self, forKey: .productVideo)
        coloToProductRef = try values.decodeIfPresent(String.self, forKey: .coloToProductRef)
        colorRef = try values.decodeIfPresent(String.self, forKey: .colorRef)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        sizeToColorRef = try values.decodeIfPresent(String.self, forKey: .sizeToColorRef)
        sizeRef = try values.decodeIfPresent(String.self, forKey: .sizeRef)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
    }

}
