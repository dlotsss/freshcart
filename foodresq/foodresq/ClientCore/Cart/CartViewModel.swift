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
        Task {try await fetchPositions() }
        Task {try await fetchAddedToCartPositions() }
    }
     
    @MainActor
    func fetchPositions() async throws {
        self.positions = try await PositionService.fetchCartPositions()
    }
    
    func fetchAddedToCartPositions() async throws{
        let uid = user.id
        service.fetchAddedToCartPositions(forUid: uid) { positions in
            self.addedToCartPositions = positions
        }
        
       // self.positions = try await PositionService.fetchCartPositions()
        
        var positions = [Position]()
        Firestore.firestore().collection("restaurants").document(uid).collection("user-cart").getDocuments {snapshot, _ in
            guard let documents = snapshot?.documents else {return }
                documents.forEach { doc in
                    let positionID = doc.documentID
                    let positionCollection = Firestore.firestore().collection("positions").document(positionID)
                    self.listener = positionCollection.addSnapshotListener{snapshot, error in
                        guard let snapshot = snapshot else { return }
                        DispatchQueue.main.async {
                            if let position = try? snapshot.data(as: Position.self) {
                                                    self.positions.append(position)
                            } else {
                                print("Failed to decode document as Position")
                            }
                        }
                    }
                    
//                    Firestore.firestore().collection("positions").document(positionID).getDocument { snapshot, _ in
//                        guard let position = try? snapshot?.data(as: Position.self) else { return }
//                        positions.append(position)
//                        completion(positions)
//                    }
                }
            }
        
        
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
}
