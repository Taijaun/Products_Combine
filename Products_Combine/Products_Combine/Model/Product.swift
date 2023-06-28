//
//  Product.swift
//  Products_Combine
//
//  Created by Taijaun Pitt on 28/06/2023.
//

import Foundation

struct Products: Decodable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
}
