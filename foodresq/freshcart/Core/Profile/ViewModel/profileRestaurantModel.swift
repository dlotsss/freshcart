//
//  profileRestaurantModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import FirebaseFirestore
import Combine

class profileRestaurantModel: ObservableObject{
    let user: User
    @Published var positions = [Position]()
    private var listener: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user){
            UserDefaults.standard.set(encoded, forKey: "user")
        }
        Task{
            try await fetchUserPositions()
        }
    }
    
    @MainActor
    func fetchUserPositions() async throws {
        let positionCollection = Firestore.firestore().collection("positions").whereField("ownerUid", isEqualTo: user.id)
        listener = positionCollection.addSnapshotListener{snapshot, error in
            guard let snapshot = snapshot else { return }
            DispatchQueue.main.async {
                self.positions = snapshot.documents.compactMap{ document in
                    try? document.data(as: Position.self)
                }
            }
        }
        
//        self.positions = try await PositionService.fetchUserPositions(withUid: user.id)
//        print(self.positions)
//        
//        for i in 0 ..< positions.count {
//            positions[i].user = self.user
//        }
    }
    
}
