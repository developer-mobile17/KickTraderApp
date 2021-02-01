//
//  SellerGetProductByRef.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/02/21.
//  Copyright © 2021 VikasSIngh. All rights reserved.
//

import Foundation

struct SelelrGetProductDetailsRequest: Encodable {
    let productRef:String
    let buyerRef: String
}

struct SelelrGetProductDetailsResponse : Codable {
    let status : String?
    let productInfo : SellerProductInfo?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case productInfo = "productInfo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        productInfo = try values.decodeIfPresent(SellerProductInfo.self, forKey: .productInfo)
    }

}
struct SellerProductInfo : Codable {
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
    let favorite : Bool?
    let brandName : String?
    let colors : [SellerCOlors]?
    let comments : [SellerComments]?
    let unboxingVideos : [SellerUnboxingVideos]?
    let sellerDetail : SellerCompleteDetail?

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
        case favorite = "favorite"
        case brandName = "brandName"
        case colors = "colors"
        case comments = "comments"
        case unboxingVideos = "unboxingVideos"
        case sellerDetail = "sellerDetail"
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
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        colors = try values.decodeIfPresent([SellerCOlors].self, forKey: .colors)
        comments = try values.decodeIfPresent([SellerComments].self, forKey: .comments)
        unboxingVideos = try values.decodeIfPresent([SellerUnboxingVideos].self, forKey: .unboxingVideos)
        sellerDetail = try values.decodeIfPresent(SellerCompleteDetail.self, forKey: .sellerDetail)
    }

}


struct SellerCOlors : Codable {
    let id : String?
    let colorRef : String?
    let colorName : String?
    let colorCode : String?
    let colorStatus : String?
    let coloToProductRef : String?
    let size : [SellerSIze]?
    let image : [SellerImage]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case colorRef = "colorRef"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case colorStatus = "colorStatus"
        case coloToProductRef = "coloToProductRef"
        case size = "size"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        colorRef = try values.decodeIfPresent(String.self, forKey: .colorRef)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        colorStatus = try values.decodeIfPresent(String.self, forKey: .colorStatus)
        coloToProductRef = try values.decodeIfPresent(String.self, forKey: .coloToProductRef)
        size = try values.decodeIfPresent([SellerSIze].self, forKey: .size)
        image = try values.decodeIfPresent([SellerImage].self, forKey: .image)
    }

}



struct SellerSIze : Codable {
    let id : String?
    let sizeRef : String?
    let sizeName : String?
    let sizeStatus : String?
    let sizeToColorRef : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case sizeRef = "sizeRef"
        case sizeName = "sizeName"
        case sizeStatus = "sizeStatus"
        case sizeToColorRef = "sizeToColorRef"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        sizeRef = try values.decodeIfPresent(String.self, forKey: .sizeRef)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        sizeStatus = try values.decodeIfPresent(String.self, forKey: .sizeStatus)
        sizeToColorRef = try values.decodeIfPresent(String.self, forKey: .sizeToColorRef)
    }

}


struct SellerImage : Codable {
    let id : String?
    let imageToProductRef : String?
    let productRef : String?
    let colorToProductRef : String?
    let imageName : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case imageToProductRef = "imageToProductRef"
        case productRef = "productRef"
        case colorToProductRef = "colorToProductRef"
        case imageName = "imageName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        imageToProductRef = try values.decodeIfPresent(String.self, forKey: .imageToProductRef)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        colorToProductRef = try values.decodeIfPresent(String.self, forKey: .colorToProductRef)
        imageName = try values.decodeIfPresent(String.self, forKey: .imageName)
    }

}


struct SellerCompleteDetail : Codable {
    let id : String?
    let userRef : String?
    let full_Name : String?
    let appleId : String?
    let email : String?
    let mobile : String?
    let password : String?
    let pwd : String?
    let role : String?
    let address : String?
    let gender : String?
    let profile_Image : String?
    let open_time : String?
    let close_time : String?
    let shop_description : String?
    let is_Active : String?
    let deviceToken : String?
    let mobileType : String?
    let notification : String?
    let loginStatus : String?
    let location : String?
    let validation_Code : String?
    let disputeCount : String?
    let isSuspend : String?
    let suspendTill : String?
    let createdDtm : String?
    let avgRating : String?
    let totalReview : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userRef = "userRef"
        case full_Name = "Full_Name"
        case appleId = "AppleId"
        case email = "Email"
        case mobile = "Mobile"
        case password = "Password"
        case pwd = "pwd"
        case role = "Role"
        case address = "address"
        case gender = "gender"
        case profile_Image = "Profile_Image"
        case open_time = "open_time"
        case close_time = "close_time"
        case shop_description = "shop_description"
        case is_Active = "Is_Active"
        case deviceToken = "deviceToken"
        case mobileType = "mobileType"
        case notification = "notification"
        case loginStatus = "loginStatus"
        case location = "location"
        case validation_Code = "Validation_Code"
        case disputeCount = "disputeCount"
        case isSuspend = "isSuspend"
        case suspendTill = "suspendTill"
        case createdDtm = "createdDtm"
        case avgRating = "avgRating"
        case totalReview = "totalReview"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        userRef = try values.decodeIfPresent(String.self, forKey: .userRef)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        appleId = try values.decodeIfPresent(String.self, forKey: .appleId)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        pwd = try values.decodeIfPresent(String.self, forKey: .pwd)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        shop_description = try values.decodeIfPresent(String.self, forKey: .shop_description)
        is_Active = try values.decodeIfPresent(String.self, forKey: .is_Active)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        mobileType = try values.decodeIfPresent(String.self, forKey: .mobileType)
        notification = try values.decodeIfPresent(String.self, forKey: .notification)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        validation_Code = try values.decodeIfPresent(String.self, forKey: .validation_Code)
        disputeCount = try values.decodeIfPresent(String.self, forKey: .disputeCount)
        isSuspend = try values.decodeIfPresent(String.self, forKey: .isSuspend)
        suspendTill = try values.decodeIfPresent(String.self, forKey: .suspendTill)
        createdDtm = try values.decodeIfPresent(String.self, forKey: .createdDtm)
        avgRating = try values.decodeIfPresent(String.self, forKey: .avgRating)
        totalReview = try values.decodeIfPresent(Int.self, forKey: .totalReview)
    }

}


struct SellerComments : Codable {
    let id : String?
    let rattingRef : String?
    let fromRef : String?
    let toRef : String?
    let rating : String?
    let comment : String?
    let create_at : String?
    let full_Name : String?
    let profile_Image : String?
    let shop_description : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case rattingRef = "rattingRef"
        case fromRef = "fromRef"
        case toRef = "toRef"
        case rating = "rating"
        case comment = "comment"
        case create_at = "create_at"
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
        case shop_description = "shop_description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        rattingRef = try values.decodeIfPresent(String.self, forKey: .rattingRef)
        fromRef = try values.decodeIfPresent(String.self, forKey: .fromRef)
        toRef = try values.decodeIfPresent(String.self, forKey: .toRef)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        create_at = try values.decodeIfPresent(String.self, forKey: .create_at)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
        shop_description = try values.decodeIfPresent(String.self, forKey: .shop_description)
    }

}


struct SellerUnboxingVideos : Codable {
    let id : String?
    let unboxingRef : String?
    let orderRef : String?
    let videoName : String?
    let buyerRef : String?
    let created_at : String?
    let unboxingVideo : String?
    let orderNumber : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case unboxingRef = "unboxingRef"
        case orderRef = "orderRef"
        case videoName = "videoName"
        case buyerRef = "buyerRef"
        case created_at = "created_at"
        case unboxingVideo = "unboxingVideo"
        case orderNumber = "orderNumber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        unboxingRef = try values.decodeIfPresent(String.self, forKey: .unboxingRef)
        orderRef = try values.decodeIfPresent(String.self, forKey: .orderRef)
        videoName = try values.decodeIfPresent(String.self, forKey: .videoName)
        buyerRef = try values.decodeIfPresent(String.self, forKey: .buyerRef)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        unboxingVideo = try values.decodeIfPresent(String.self, forKey: .unboxingVideo)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
    }

}

