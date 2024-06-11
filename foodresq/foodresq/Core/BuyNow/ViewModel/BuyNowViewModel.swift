//
//  BuyNowViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import Firebase
import Combine
import FirebaseFirestore

class BuyNowViewModel: ObservableObject{
    @Published var positions = [Position]()
    private var listener: ListenerRegistration?
    init() {
        Task {try await fetchPositions() }
    }
     
    @MainActor
    func fetchPositions() async throws {
        self.positions = try await PositionService.fetchAllBuyNowPositions()
        
//        let positionCollection = Firestore.firestore().collection("positions")
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
