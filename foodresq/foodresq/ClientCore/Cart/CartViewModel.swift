//
//  CartViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

class CartViewModel: ObservableObject{
    @Published var positions = [Position]()
    @Published var addedToCartPositions = [Position]()
    let user: User
    let service = PositionService()
    private let userService = UserService()
    
    private var listener: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        Task {try await fetchCartPositions(uid: user.id) }
        //Task {try await fetchAddedToCartPositions() }
    }
    
    @MainActor
    func fetchCartPositions(uid: String) async throws {
        self.positions = try await PositionService.fetchCartPositions(uid: uid)
    }
    
    func purchase(positons: [Position]) {
        service.purchase(positions) {
            
        }
        for i in 0..<positons.count {
            self.positions[i].addedToCart = false
        }
    }
    
    //    func fetchAddedToCartPositions() async throws{
    //        let uid = user.id
    //        service.fetchAddedToCartPositions(forUid: uid) { positions in
    //            self.addedToCartPositions = positions
    //        }
    
    // self.positions = try await PositionService.fetchCartPositions()
    
    
    
    
    
    
    
    
    //        let query = Firestore.firestore().collection("users").document(self.user.id).collection("user-cart").whereField("userAdded", isEqualTo: self.user.id)
    //
    //
    //        listener = query.addSnapshotListener { (snapshot, error) in
    //                    guard let documents = snapshot?.documents else {
    //                        print("No documents")
    //                        return
    //                    }
    //
    //                    self.addedToCartPositions = documents.compactMap { queryDocumentSnapshot -> Position? in
    //                        let data = queryDocumentSnapshot.data()
    //                        let id = data["id"]
    //                        let foodName = data["name"]
    //                        let price = data["price"]
    //                        let quantity = data["quantity"]
    //                        var addedToCart = data["addedToCart"]
    //                        let ownerUid = data["ownerUid"]
    //                        let imageUrl = data["imageUrl"]
    //                        return Position(id: id as! String, ownerUid: ownerUid as! String, foodName: foodName as! String, price: price as! Int, imageUrl: imageUrl as! String, quantity: quantity as! Int)
    //                    }
    //                }
    //
    
    
    
    
    
    
    
    
    //        var positions = [Position]()
    //        Firestore.firestore().collection("restaurants").document(uid).collection("user-cart").getDocuments {snapshot, _ in
    //            guard let documents = snapshot?.documents else {return }
    //                documents.forEach { doc in
    //                    let positionID = doc.documentID
    //                    let positionCollection = Firestore.firestore().collection("positions").document(positionID)
    //                    self.listener = positionCollection.addSnapshotListener{snapshot, error in
    //                        guard let snapshot = snapshot else { return }
    //                        DispatchQueue.main.async {
    //                            if let position = try? snapshot.data(as: Position.self) {
    //                                                    self.positions.append(position)
    //                            } else {
    //                                print("Failed to decode document as Position")
    //                            }
    //                        }
    //                    }
    //
    //                    Firestore.firestore().collection("positions").document(positionID).getDocument { snapshot, _ in
    //                        guard let position = try? snapshot?.data(as: Position.self) else { return }
    //                        positions.append(position)
    //                        completion(positions)
    //                    }
    //                }
    //
    
    //        let positionCollection = Firestore.firestore().collection("restaurants").whereField("ownerUid", isEqualTo: user.id)
    //        listener = positionCollection.addSnapshotListener{snapshot, error in
    //            guard let snapshot = snapshot else { return }
    //            DispatchQueue.main.async {
    //                self.positions = snapshot.documents.compactMap{ document in
    //                    try? document.data(as: Position.self)
    //                }
    //            }
    //        }
    
}
