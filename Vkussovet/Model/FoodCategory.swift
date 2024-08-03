//
//  FoodCategory.swift
//  Vkussovet
//
//  Created by Ivan Elonov on 30.07.2024.
//

import Foundation

struct CategoryResponse: Codable {
    let status: Bool
    let menuList: [FoodCategory]
}

struct FoodCategory: Codable {
    let menuID: String?
    let image: String?
    let name: String?
    let subMenuCount: Int?
}
