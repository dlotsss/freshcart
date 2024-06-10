//
//  CartViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 03.06.2024.
//

import Foundation

class CartCellViewModel: ObservableObject{
    @Published var position: Position
    private let service = PositionService()
    
    init(position: Position) {
        self.position = position
    }
    
    func deleteFromCart() {
        service.deleteFromCart(position) {
            self.position.addedToCart = false
        }
    }
}
