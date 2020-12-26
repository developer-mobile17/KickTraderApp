//
//  SearchGetProductModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 17/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
struct getSellerProducts : Encodable {
    let sellerRef:String
}



struct getBuyerProducts : Encodable {
    let buyerRef:String
}

// MARK: - Welcome
struct ResponsegetSellerProducts: Codable {
    let status : String?
    let msg : String?
    let sneakers : [Sneakers]?
    let shoes : [Shoes]?
    let boots : [Boot]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case sneakers = "sneakers"
        case shoes = "shoes"
        case boots = "boots"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        sneakers = try values.decodeIfPresent([Sneakers].self, forKey: .sneakers)
        shoes = try values.decodeIfPresent([Shoes].self, forKey: .shoes)
        boots = try values.decodeIfPresent([Boot].self, forKey: .boots)
    }

}


// MARK: - Boot
struct Sneakers: Codable {
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
    let created_at : String?
    let category_Name : String?
    let brandName : String?
    let favoriteId : String?
    let AverageRating : String?
   

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
        case created_at = "created_at"
        case category_Name = "category_Name"
        case brandName = "brandName"
        case favoriteId = "favoriteId"
        case AverageRating = "AverageRating"
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
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        category_Name = try values.decodeIfPresent(String.self, forKey: .category_Name)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        favoriteId = try values.decodeIfPresent(String.self, forKey: .favoriteId)
        AverageRating = try values.decodeIfPresent(String.self, forKey: .AverageRating)
    }

}


// MARK: - Boot
struct Shoes: Codable {
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
    let created_at : String?
    let category_Name : String?
    let brandName : String?
    let favoriteId : String?
    let AverageRating : String?
    

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
        case created_at = "created_at"
        case category_Name = "category_Name"
        case brandName = "brandName"
        case favoriteId = "favoriteId"
        case AverageRating = "AverageRating"
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
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        category_Name = try values.decodeIfPresent(String.self, forKey: .category_Name)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        favoriteId = try values.decodeIfPresent(String.self, forKey: .favoriteId)
        AverageRating = try values.decodeIfPresent(String.self, forKey: .AverageRating)
    }

}

// MARK: - Boot
struct Boot: Codable {
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
    let created_at : String?
    let category_Name : String?
    let brandName : String?
    let favoriteId : String?
    let AverageRating : String?

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
        case created_at = "created_at"
        case category_Name = "category_Name"
        case brandName = "brandName"
        case favoriteId = "favoriteId"
        case AverageRating = "AverageRating"
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
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        category_Name = try values.decodeIfPresent(String.self, forKey: .category_Name)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        favoriteId = try values.decodeIfPresent(String.self, forKey: .favoriteId)
        AverageRating = try values.decodeIfPresent(String.self, forKey: .AverageRating)
    }

}
