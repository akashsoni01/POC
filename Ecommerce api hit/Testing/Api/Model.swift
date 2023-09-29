//
//  Model.swift
//  Testing
//
//  Created by Akash soni on 29/09/23.
//

import Foundation

struct BaseModel: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
//    let price: String
//    let discountPercentage: String?
//    let rating: String?
//    let stock: String?
//    let brand: String?
//    let category: String?
//    let thumbnail: String?
    let images: [String]?
}
