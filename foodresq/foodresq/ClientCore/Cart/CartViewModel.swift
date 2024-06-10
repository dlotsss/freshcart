//
//  CartViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation
import Firebase

class CartViewModel: ObservableObject{
    @Published var positions = [Position]()
    @Published var addedToCartPositions = [Position]()
    let user: User
    let service = PositionService()
    private let userService = UserService()
    
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
//        let uid = user.id
//        service.fetchAddedToCartPositions(forUid: uid) { positions in
//            self.addedToCartPositions = positions
//        }
        
        self.positions = try await PositionService.fetchCartPositions()
    }
}
