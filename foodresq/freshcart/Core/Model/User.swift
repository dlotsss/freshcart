//
//  User.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    let username: String
    let login: String
    let isRest: Bool
    var name: String?
    var description: String?
    var profileImage: String?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
    
    static var defaultUser: User {
            return User(id: "defaultID", username: "Default User", login: "default@example.com", isRest: false, profileImage: nil)
        }
}

extension User{
    static var MOCK_USERS: [User] = [
        .init(id: UUID().uuidString, username: "Palermo", login: "palermoitalianrest@gmail.com", isRest: true, description: "Уютное заведение, в меню которого итальянские пиццы, пасты, свежие салаты и десерты. ", profileImage: nil),
        .init(id: UUID().uuidString, username: "Turandot", login: "turandotchineserest@gmail.com", isRest: true, description: "Китайский ресторан Turandot предлагает аутентичные блюда в роскошной восточной обстановке, создавая незабываемую атмосферу для своих гостей.", profileImage: nil),
        .init(id: UUID().uuidString, username: "Hani Brunch", login: "hanibrunchrest@gmail.com", isRest: true, description: "уютное кафе, где подают вкусные и здоровые завтраки и бранчи, приготовленные из свежих и натуральных ингредиентов.", profileImage: nil),
        .init(id: UUID().uuidString, username: "Три медведя", login: "trimedvedyarest@gmail.com", isRest: true, description: "Ресторан Три Медведя предлагает своим гостям уютную атмосферу и разнообразное меню с блюдами традиционной русской кухни, приготовленными по старинным рецептам.", profileImage: "tri-medvedya"),
        .init(id: UUID().uuidString, username: "Blackberry", login: "blackberryrest@gmail.com", isRest: true, description: "Blackberry — стильное кафе, где гости могут насладиться ароматным кофе и изысканными десертами в уютной и современной обстановке.", profileImage: "blackberry"),
        .init(id: UUID().uuidString, username: "dlotsss", login: "dlotsss@gmail.com", isRest: false)
    ]
}

