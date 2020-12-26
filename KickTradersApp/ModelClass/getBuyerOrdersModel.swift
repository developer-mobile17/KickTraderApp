//
//  getBuyerOrdersModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 01/12/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct getBuyerOrders: Encodable {
    let buyerRef: String
}

struct getBuyerOrdersResponse: Codable {
    let status : String?
    let msg : String?
    let buyerOrders : [BuyerOrders]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case buyerOrders = "buyerOrders"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        buyerOrders = try values.decodeIfPresent([BuyerOrders].self, forKey: .buyerOrders)
    }

}

struct BuyerOrders : Codable {
    let id : String?
    let orderNumber : String?
    let buyerRef : String?
    let sellerRef : String?
    let paymentType : String?
    let paymentStatus : String?
    let productRef : String?
    let coloToProductRef : String?
    let sizeToColorRef : String?
    let bidPrice : String?
    let orderedBidRef : String?
    let grandTotal : String?
    let shipingAddress : ShipingAddress?
    let orderedDate : String?
    let orderStatus : String?
    let productName : String?
    let brandName : String?
    let productCoverImage : String?
    let colorRef : String?
    let colorName : String?
    let colorCode : String?
    let colorStatus : String?
    let sizeRef : String?
    let sizeName : String?
    let sizeStatus : String?
    let sellerInfo : SellerInfo?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case orderNumber = "orderNumber"
        case buyerRef = "buyerRef"
        case sellerRef = "sellerRef"
        case paymentType = "paymentType"
        case paymentStatus = "paymentStatus"
        case productRef = "productRef"
        case coloToProductRef = "coloToProductRef"
        case sizeToColorRef = "sizeToColorRef"
        case bidPrice = "bidPrice"
        case orderedBidRef = "orderedBidRef"
        case grandTotal = "grandTotal"
        case shipingAddress = "shipingAddress"
        case orderedDate = "orderedDate"
        case orderStatus = "orderStatus"
        case productName = "productName"
        case brandName = "brandName"
        case productCoverImage = "productCoverImage"
        case colorRef = "colorRef"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case colorStatus = "colorStatus"
        case sizeRef = "sizeRef"
        case sizeName = "sizeName"
        case sizeStatus = "sizeStatus"
        case sellerInfo = "sellerInfo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
        buyerRef = try values.decodeIfPresent(String.self, forKey: .buyerRef)
        sellerRef = try values.decodeIfPresent(String.self, forKey: .sellerRef)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
        paymentStatus = try values.decodeIfPresent(String.self, forKey: .paymentStatus)
        productRef = try values.decodeIfPresent(String.self, forKey: .productRef)
        coloToProductRef = try values.decodeIfPresent(String.self, forKey: .coloToProductRef)
        sizeToColorRef = try values.decodeIfPresent(String.self, forKey: .sizeToColorRef)
        bidPrice = try values.decodeIfPresent(String.self, forKey: .bidPrice)
        orderedBidRef = try values.decodeIfPresent(String.self, forKey: .orderedBidRef)
        grandTotal = try values.decodeIfPresent(String.self, forKey: .grandTotal)
        shipingAddress = try values.decodeIfPresent(ShipingAddress.self, forKey: .shipingAddress)
        orderedDate = try values.decodeIfPresent(String.self, forKey: .orderedDate)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        colorRef = try values.decodeIfPresent(String.self, forKey: .colorRef)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        colorStatus = try values.decodeIfPresent(String.self, forKey: .colorStatus)
        sizeRef = try values.decodeIfPresent(String.self, forKey: .sizeRef)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        sizeStatus = try values.decodeIfPresent(String.self, forKey: .sizeStatus)
        sellerInfo = try values.decodeIfPresent(SellerInfo.self, forKey: .sellerInfo)
    }

}

struct ShipingAddress : Codable {
    let deliveredTo : String?
    let mobile : String?
    let address : String?
    let city : String?
    let state : String?
    let pin : String?

    enum CodingKeys: String, CodingKey {

        case deliveredTo = "deliveredTo"
        case mobile = "mobile"
        case address = "address"
        case city = "city"
        case state = "state"
        case pin = "pin"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        deliveredTo = try values.decodeIfPresent(String.self, forKey: .deliveredTo)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        pin = try values.decodeIfPresent(String.self, forKey: .pin)
    }

}

struct SellerInfo : Codable {
    let userRef : String?
    let full_Name : String?
    let profile_Image : String?
    let shop_description : String?

    enum CodingKeys: String, CodingKey {

        case userRef = "userRef"
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
        case shop_description = "shop_description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userRef = try values.decodeIfPresent(String.self, forKey: .userRef)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
        shop_description = try values.decodeIfPresent(String.self, forKey: .shop_description)
    }

}
