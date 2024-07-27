//
//  PostService.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import Firebase

struct PositionService{
    
    static func fetchAllBuyNowPositions() async throws -> [Position] {
        let snapshot = try await Firestore.firestore().collection("positions").getDocuments()
        print(snapshot.documents)
        var positions = try snapshot.documents.compactMap({ document in
            try document.data(as: Position.self)
        })
        
        for i in 0..<positions.count {
            let position = positions[i]
            let ownerUid = position.ownerUid
            let positionUser = try await UserService.fetchUser(withUid: ownerUid)
            positions[i].user = positionUser
        }
        
        return positions
    }
    
    static func fetchCartPositions(uid: String) async throws -> [Position] {
      //  let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-cart").getDocuments()
        let snapshot = try await Firestore.firestore().collection("positions").whereField("addedToCartID", arrayContains: uid).getDocuments()
        print(snapshot.documents)
        var positions = try snapshot.documents.compactMap({ document in
            try document.data(as: Position.self)
        })
        
        for i in 0..<positions.count {
            let position = positions[i]
            let ownerUid = position.ownerUid
            let positionUser = try await UserService.fetchUser(withUid: ownerUid)
            positions[i].user = positionUser
        }
        
        return positions
    }

    
    static func fetchUserPositions(withUid uid: String) async throws -> [Position] {
        let snapshot = try await Firestore.firestore().collection("positions").whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Position.self) })
    }

}

extension PositionService{
    func addToCart(_ position: Position, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let positionId = position.id
        guard var whoAddedIDArray = position.addedToCartID else {return }
        if !whoAddedIDArray.contains(uid) {
                   whoAddedIDArray.append(uid)
               }
        guard position.quantity > 0 else {return}
        let userCartRef = Firestore.firestore().collection("restaurants").document(uid).collection("user-cart")
    
        Firestore.firestore().collection("positions").document(positionId).updateData(["quantity": position.quantity - 1,
                                                                                       //"addedToCart": !position.addedToCart!,
                                                                                       "addedToCartID": whoAddedIDArray]) {_ in
            userCartRef.document(positionId).setData([:]) { _ in
                completion()
            }
        }
    }
    
    func checkIfPositionIsAdded(_ position: Position, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let positionId = position.id
        
        Firestore.firestore().collection("restaurants").document(uid).collection("user-cart").document(positionId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else {return }
            completion(snapshot.exists)
        }
    }
    
    func deleteFromCart(_ position: Position, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let positionId = position.id
        guard var whoAddedIDArray = position.addedToCartID else {return }
        whoAddedIDArray.removeAll { $0 == uid }
        let userCartRef = Firestore.firestore().collection("restaurants").document(uid).collection("user-cart")
        
        
        Firestore.firestore().collection("positions").document(positionId).updateData(["quantity": position.quantity + 1,
                                                                                       //"addedToCart": !position.addedToCart!,
                                                                                       "addedToCartID": whoAddedIDArray]) {_ in
            userCartRef.document(positionId).delete { _ in
                completion()
            }
        }
    }
    
    func purchase(_ positions: [Position], completion: @escaping() -> Void) {
        for i in 0..<positions.count{
            guard let uid = Auth.auth().currentUser?.uid else {return }
            print(uid)
            let positionId = positions[i].id
            guard var whoAddedIDArray = positions[i].addedToCartID else {return }
            whoAddedIDArray.removeAll { $0 == uid }
            let allPositionsRef = Firestore.firestore().collection("positions")
            let userCartRef = Firestore.firestore().collection("restaurants").document(uid).collection("user-cart")
            
            if positions[i].quantity < 1{
                allPositionsRef.document(positionId).delete{_ in
                    completion()
                }
                
                userCartRef.document(positionId).delete { _ in
                    completion()
                }
            } else {
                allPositionsRef.document(positionId).updateData(["quantity": positions[i].quantity,
                                                                // "addedToCart": !positions[i].addedToCart!,
                                                                 "addedToCartID": whoAddedIDArray])
                userCartRef.document(positionId).delete { _ in
                    completion()
                }
            }
        }
    }
    
//    func fetchAddedToCartPositions(forUid uid: String, completion: @escaping([Position]) -> Void) {
//        print(333333)
//        var positions = [Position]()
//        Firestore.firestore().collection("restaurants").document(uid).collection("user-cart").getDocuments {snapshot, _ in
//            guard let documents = snapshot?.documents else {return }
//            print(documents)
//                documents.forEach { doc in
//                    let positionID = doc.documentID
//                    
//                    Firestore.firestore().collection("positions").document(positionID).getDocument { snapshot, _ in
//                        guard let position = try? snapshot?.data(as: Position.self) else { return }
//                        positions.append(position)
//                        completion(positions)
//                    }
//                }
//            }
//    }
}
