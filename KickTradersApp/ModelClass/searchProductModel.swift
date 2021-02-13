//
//  searchProductModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 12/02/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation
struct searchProductRequest:Encodable {
    let searchText:String
    let brand:String
    let color:[String]
    let gender:String
}

struct searchProductResponse:Codable {
    let status : String?
    let msg : String?
    let searchResult : [SearchResult]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case searchResult = "searchResult"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        searchResult = try values.decodeIfPresent([SearchResult].self, forKey: .searchResult)
    }

}

struct SearchResult : Codable {
    let id : String?
    let productRef : String?
    let sellerRef : String?
    let productName : String?
    let productCategoryRef : String?
    let productSubCategory : String?
    let productPrice : String?
    let productBrandRef : String?
    let productDescription : String?
    let productStatus : String?
    let productCoverImage : String?
    let productVideo : String?
    let authCount : String?
    let created_at : String?
    let averageRating : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case productRef = "productRef"
        case sellerRef = "sellerRef"
        case productName = "productName"
        case productCategoryRef = "productCategoryRef"
        case productSubCategory = "productSubCategory"
        case productPrice = "productPrice"
        case productBrandRef = "productBrandRef"
        case productDescription = "productDescription"
        case productStatus = "productStatus"
        case productCoverImage = "productCoverImage"
        case productVideo = "productVideo"
        case authCount = "authCount"
        case created_at = "created_at"
        case averageRating = "AverageRating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        sellerRef = try values.decodeIfPresent(String.self, forKey: .sellerRef)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        productCategoryRef = try values.decodeIfPresent(String.self, forKey: .productCategoryRef)
        productSubCategory = try values.decodeIfPresent(String.self, forKey: .productSubCategory)
        productPrice = try values.decodeIfPresent(String.self, forKey: .productPrice)
        productBrandRef = try values.decodeIfPresent(String.self, forKey: .productBrandRef)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        productStatus = try values.decodeIfPresent(String.self, forKey: .productStatus)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        productVideo = try values.decodeIfPresent(String.self, forKey: .productVideo)
        authCount = try values.decodeIfPresent(String.self, forKey: .authCount)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        averageRating = try values.decodeIfPresent(String.self, forKey: .averageRating)
    }

}
