//
//  profileRestaurantModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation

class profileRestaurantModel: ObservableObject{
    let user: User
    @Published var positions = [Position]()
    
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
        self.positions = try await PositionService.fetchUserPositions(withUid: user.id)
        print(self.positions)
        
        for i in 0 ..< positions.count {
            positions[i].user = self.user
        }
    }
}
