//
//  BuyNowViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import Firebase

class BuyNowViewModel: ObservableObject{
    @Published var positions = [Position]()
    
    init() {
        Task {try await fetchPositions() }
    }
     
    @MainActor
    func fetchPositions() async throws {
        self.positions = try await PositionService.fetchAllBuyNowPositions()
    }
}
