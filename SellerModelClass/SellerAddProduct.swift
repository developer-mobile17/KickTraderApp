//
//  SellerAddProduct.swift
//  KickTradersApp
//
//  Created by anil kumar on 18/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct SellerAddProductModel:Encodable {
    let name:String
    let categoryRef:String
    let subCategory:String
    let price:String
    let brandRef:String
    let description:String
    let sellerRef:String
    let productVideo:String
    let productCoverImage:String
}



struct SellerResponseAddProduct: Codable {
    let status, msg: String
    let productRef: ProductRef
}

// MARK: - ProductRef
struct ProductRef: Codable {
    let id, productRef, sellerRef, productName: String
    let productCategoryRef, productSubCategory, productPrice, productBrandRef: String
    let productDescription, productStatus, productCoverImage, productVideo: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, productRef, sellerRef, productName, productCategoryRef, productSubCategory, productPrice, productBrandRef, productDescription, productStatus, productCoverImage, productVideo
        case createdAt = "created_at"
    }
}
