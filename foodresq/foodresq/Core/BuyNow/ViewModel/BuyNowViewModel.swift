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
        startListeningForRealTimeUpdates()
    }
     
    @MainActor
    func fetchPositions() async throws {
      self.positions = try await PositionService.fetchAllBuyNowPositions()
        
    }
    
    private func startListeningForRealTimeUpdates() {
            let db = Firestore.firestore()
            listener = db.collection("positions").addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error fetching data: \(error!)")
                    return
                }
                DispatchQueue.main.async {
                    Task {try await self.fetchPositions()}
                }
            }
        }
}
