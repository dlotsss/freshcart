//
//  UserService.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import Firebase

struct UserService{
    static func fetchAllUsers() async throws -> [User]{
        let snapshot = try await Firestore.firestore().collection("restaurants").whereField("isRest", isEqualTo: true).getDocuments()
        return snapshot.documents.compactMap({try? $0.data(as: User.self)})
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try? await Firestore.firestore().collection("restaurants").document(uid).getDocument()
        return try snapshot!.data(as: User.self)
    }
}

