//
//  SellerOrderModel.swift
//  KickTradersApp
//
//  Created by anil kumar on 17/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation

struct SellerOrderModel:Encodable {
    let sellerRef: String
}

// MARK: - Welcome
struct ResponseSellerOrderModel: Codable {
    let status : String?
    let msg : String?
    let url : String?
    let orders : Orders?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case url = "url"
        case orders = "orders"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        orders = try values.decodeIfPresent(Orders.self, forKey: .orders)
    }

}

// MARK: - Orders
struct Orders: Codable {
    let pending : [Pending]?
    let upcoming : [Upcoming]?
    let cancelled : [Cancelled]?
    let history : [History]?

    enum CodingKeys: String, CodingKey {

        case pending = "Pending"
        case upcoming = "Upcoming"
        case cancelled = "Cancelled"
        case history = "History"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pending = try values.decodeIfPresent([Pending].self, forKey: .pending)
        upcoming = try values.decodeIfPresent([Upcoming].self, forKey: .upcoming)
        cancelled = try values.decodeIfPresent([Cancelled].self, forKey: .cancelled)
        history = try values.decodeIfPresent([History].self, forKey: .history)
    }

}


// MARK: - Upcoming
struct Pending: Codable {
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
    let full_Name : String?
    let profile_Image : String?

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
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
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
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
    }

}


// MARK: - Upcoming
struct Upcoming: Codable {
    let id : String?
    let cartRef : String?
    let buyerRef : String?
    let productRef : String?
    let coloToProductRef : String?
    let sizeToColorRef : String?
    let bidPrice : String?
    let status : String?
    let productName : String?
    let brandName : String?
    let productCoverImage : String?
    let colorRef : String?
    let colorName : String?
    let colorCode : String?
    let sizeRef : String?
    let sizeName : String?
    let shipingAddress : String?

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
        case brandName = "brandName"
        case productCoverImage = "productCoverImage"
        case colorRef = "colorRef"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case sizeRef = "sizeRef"
        case sizeName = "sizeName"
        case shipingAddress = "shipingAddress"
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
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        productCoverImage = try values.decodeIfPresent(String.self, forKey: .productCoverImage)
        colorRef = try values.decodeIfPresent(String.self, forKey: .colorRef)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        sizeRef = try values.decodeIfPresent(String.self, forKey: .sizeRef)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        shipingAddress = try values.decodeIfPresent(String.self, forKey: .shipingAddress)
    }

}

// MARK: - Cancelled
struct Cancelled: Codable {
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
    let full_Name : String?
    let profile_Image : String?

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
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
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
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
    }

}


// MARK: - Cancelled
struct History: Codable {
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
    let full_Name : String?
    let profile_Image : String?

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
        case full_Name = "Full_Name"
        case profile_Image = "Profile_Image"
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
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        profile_Image = try values.decodeIfPresent(String.self, forKey: .profile_Image)
    }

}





