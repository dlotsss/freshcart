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
    
    init(position: Position) {
        self.position = position
        checkIfPositionIsAdded()
        //startListening()
    }
    
    func addToCart() {
        service.addToCart(position) {
            self.position.addedToCart = true
            self.position.addedToCartID = Auth.auth().currentUser?.uid
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
            self.position.addedToCart = false  
            self.position.addedToCartID = ""
        }
    }
}
