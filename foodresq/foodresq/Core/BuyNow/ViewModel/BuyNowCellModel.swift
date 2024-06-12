//
//  BuyNowCellModel.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class BuyNowCellModel: ObservableObject{
    @Published var position: Position
    private let service = PositionService()
    private var listener: ListenerRegistration?
    let user: User
    
    init(position: Position, user: User) {
        self.position = position
        
        //startListening()
        self.user = user
        checkIfPositionIsAdded()
    }
    
    func addToCart() {
        service.addToCart(position) {
            guard var whoAddedIDArray = self.position.addedToCartID else {return }
            self.position.addedToCart = true
            let currentUserUID = Auth.auth().currentUser?.uid ?? ""
            if !whoAddedIDArray.contains(currentUserUID) {
                       whoAddedIDArray.append(currentUserUID)
                   }
            self.position.addedToCartID = whoAddedIDArray   
            print(Auth.auth().currentUser?.uid ?? "")
        }
    }
    
    func checkIfPositionIsAdded() {
        service.checkIfPositionIsAdded(position) { addedToCart in
            if addedToCart{
                self.position.addedToCart = true
            }
        }
    }
//    
//    func startListening() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let positionId = position.id 
//            
//            let db = Firestore.firestore()
//            let userCartCollection = db.collection("restaurants").document(uid).collection("user-cart")
//            
//            listener = userCartCollection.document(positionId).addSnapshotListener { snapshot, error in
//                guard let snapshot = snapshot else { return }
//                if !snapshot.exists {
//                    self.position.addedToCart = false
//                }
//            }
//        }
    
    func deleteFromCart() {
        service.deleteFromCart(position) {
            guard var whoAddedIDArray = self.position.addedToCartID else {return }
            whoAddedIDArray.removeAll { $0 == self.user.id }
            self.position.addedToCart = false
            self.position.addedToCartID = whoAddedIDArray
        }
    }
}
