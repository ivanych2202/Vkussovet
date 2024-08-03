//
//  FoodName.swift
//  Vkussovet
//
//  Created by Ivan Elonov on 30.07.2024.
//

import Foundation

struct NameResponse: Codable {
    let status: Bool
    let menuList: [FoodName]
}

struct FoodName: Codable {
    let id: String?
    let image: String?
    let name: String?
    let content: String?
    let price: String?
    let weight: String?
    let spicy: String?
}
