//
//  Position.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import Foundation

struct Position: Identifiable, Codable, Hashable {
    let id: String
    let ownerUid: String
    let foodName: String
    let price: Int
    let imageUrl: String
    let quantity: Int
    var user: User?
    var addedToCart: Bool? = false 
    var addedToCartID: String? = ""
}

extension Position{
    static var MOCK_POSITIONS: [Position] = [
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, foodName: "Пицца Маргарита", price: 1700, imageUrl: "pizza", quantity: 5, user: User.MOCK_USERS[0], addedToCartID: User.MOCK_USERS[5].id),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, foodName: "Ролл Филадельфия", price: 2900, imageUrl: "filadelfia", quantity: 5,  user: User.MOCK_USERS[1]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, foodName: "Чизкейк", price: 1700, imageUrl: "cheesecake", quantity: 5,  user: User.MOCK_USERS[2]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, foodName: "Фетучини Альфредо", price: 3299, imageUrl: "fetuchini", quantity: 5,  user: User.MOCK_USERS[0]),
        .init(id: UUID().uuidString, ownerUid: UUID().uuidString, foodName: "Iced Латте", price: 900, imageUrl: "iced-latte", quantity: 5,  user: User.MOCK_USERS[4]),
    ]
}
