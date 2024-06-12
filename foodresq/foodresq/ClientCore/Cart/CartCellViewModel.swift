//
//  CartViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 03.06.2024.
//

import Foundation

class CartCellViewModel: ObservableObject{
    @Published var position: Position
    let user: User
    private let service = PositionService()
    
    init(position: Position, user: User) {
        self.position = position
        self.user = user
    }
    
    func deleteFromCart() {
        service.deleteFromCart(position) {
            guard var whoAddedIDArray = self.position.addedToCartID else {return }
            whoAddedIDArray.removeAll { $0 == self.user.id }
           // self.position.addedToCart = false
            self.position.addedToCartID = whoAddedIDArray
        }
    }
}
