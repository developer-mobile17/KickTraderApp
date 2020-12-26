//
//  BuyerGetProductDetailsModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 20/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//  BuyerGetProductDetailsModel

import Foundation



struct BuyerGetProductDetailsModel:Encodable {
    let productRef:String
}


struct BuyerGetProductDetailsModelResponse : Codable {
    let status : String?
    let productInfo : ProductInfo?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case productInfo = "productInfo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        productInfo = try values.decodeIfPresent(ProductInfo.self, forKey: .productInfo)
    }

}
struct ProductInfo : Codable {
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
    let favorite : Bool?
    let brandName : String?
    let colors : [COlors]?
    let comments : [Comments]?
    let sellerDetail : SellerDetail?

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
        case favorite = "favorite"
        case brandName = "brandName"
        case colors = "colors"
        case comments = "comments"
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
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        colors = try values.decodeIfPresent([COlors].self, forKey: .colors)
        comments = try values.decodeIfPresent([Comments].self, forKey: .comments)
        sellerDetail = try values.decodeIfPresent(SellerDetail.self, forKey: .sellerDetail)
    }

}


struct COlors : Codable {
    let id : String?
    let colorRef : String?
    let colorName : String?
    let colorCode : String?
    let colorStatus : String?
    let coloToProductRef : String?
    let size : [SIze]?
    let image : [Image]?

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
        size = try values.decodeIfPresent([SIze].self, forKey: .size)
        image = try values.decodeIfPresent([Image].self, forKey: .image)
    }

}



struct SIze : Codable {
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


struct Image : Codable {
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


struct SellerDetail : Codable {
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
    let device_Token : String?
    let mobileType : String?
    let notification : String?
    let lognStatus : String?
    let location : String?
    let validation_Code : String?
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
        case device_Token = "Device_Token"
        case mobileType = "MobileType"
        case notification = "notification"
        case lognStatus = "lognStatus"
        case location = "location"
        case validation_Code = "Validation_Code"
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
        device_Token = try values.decodeIfPresent(String.self, forKey: .device_Token)
        mobileType = try values.decodeIfPresent(String.self, forKey: .mobileType)
        notification = try values.decodeIfPresent(String.self, forKey: .notification)
        lognStatus = try values.decodeIfPresent(String.self, forKey: .lognStatus)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        validation_Code = try values.decodeIfPresent(String.self, forKey: .validation_Code)
        createdDtm = try values.decodeIfPresent(String.self, forKey: .createdDtm)
        avgRating = try values.decodeIfPresent(String.self, forKey: .avgRating)
        totalReview = try values.decodeIfPresent(Int.self, forKey: .totalReview)
    }

}


struct Comments : Codable {
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
