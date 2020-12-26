//
//  AddProductDropDownCategory.swift
//  KickTradersApp
//
//  Created by anil kumar on 16/11/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct Welcome: Codable {
    let status : String?
    let msg : String?
    let array : Array?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case array = "array"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        array = try values.decodeIfPresent(Array.self, forKey: .array)
    }

}

// MARK: - Array
struct Array: Codable {
    let categories : [Category]?
    let brands : [Brand]?
    let size : [Size]?
    let color : [Color]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
        case brands = "brands"
        case size = "size"
        case color = "color"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Category].self, forKey: .categories)
        brands = try values.decodeIfPresent([Brand].self, forKey: .brands)
        size = try values.decodeIfPresent([Size].self, forKey: .size)
        color = try values.decodeIfPresent([Color].self, forKey: .color)
    }

}

// MARK: - Brand
struct Brand: Codable {
    let id : String?
    let brandRef : String?
    let brandName : String?
    let brandStatus : String?
    let brandImage : String?
    let create_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case brandRef = "brandRef"
        case brandName = "brandName"
        case brandStatus = "brandStatus"
        case brandImage = "brandImage"
        case create_at = "create_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        brandRef = try values.decodeIfPresent(String.self, forKey: .brandRef)
        brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
        brandStatus = try values.decodeIfPresent(String.self, forKey: .brandStatus)
        brandImage = try values.decodeIfPresent(String.self, forKey: .brandImage)
        create_at = try values.decodeIfPresent(String.self, forKey: .create_at)
    }

}

// MARK: - Category
struct Category: Codable {
    let id : String?
    let category_uniqid : String?
    let category_Name : String?
    let categoryStatus : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_uniqid = "category_uniqid"
        case category_Name = "category_Name"
        case categoryStatus = "categoryStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_uniqid = try values.decodeIfPresent(String.self, forKey: .category_uniqid)
        category_Name = try values.decodeIfPresent(String.self, forKey: .category_Name)
        categoryStatus = try values.decodeIfPresent(String.self, forKey: .categoryStatus)
    }

}

// MARK: - Color
struct Color: Codable {
    let id : String?
    let colorRef : String?
    let colorName : String?
    let colorCode : String?
    let colorStatus : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case colorRef = "colorRef"
        case colorName = "colorName"
        case colorCode = "colorCode"
        case colorStatus = "colorStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        colorRef = try values.decodeIfPresent(String.self, forKey: .colorRef)
        colorName = try values.decodeIfPresent(String.self, forKey: .colorName)
        colorCode = try values.decodeIfPresent(String.self, forKey: .colorCode)
        colorStatus = try values.decodeIfPresent(String.self, forKey: .colorStatus)
    }

}

// MARK: - Size
struct Size: Codable {
    let id : String?
    let sizeRef : String?
    let sizeName : String?
    let sizeStatus : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case sizeRef = "sizeRef"
        case sizeName = "sizeName"
        case sizeStatus = "sizeStatus"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        sizeRef = try values.decodeIfPresent(String.self, forKey: .sizeRef)
        sizeName = try values.decodeIfPresent(String.self, forKey: .sizeName)
        sizeStatus = try values.decodeIfPresent(String.self, forKey: .sizeStatus)
    }

}
