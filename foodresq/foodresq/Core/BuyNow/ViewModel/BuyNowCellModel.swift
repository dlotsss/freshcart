//
//  BuyNowCellModel.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import Foundation

class BuyNowCellModel: ObservableObject{
    @Published var position: Position
    private let service = PositionService()
    
    init(position: Position) {
        self.position = position
        checkIfPositionIsAdded()
    }
    
    func addToCart() {
        service.addToCart(position) {
            self.position.addedToCart = true
        }
    }
    
    func checkIfPositionIsAdded() {
        service.checkIfPositionIsAdded(position) { addedToCart in
            if addedToCart{
                self.position.addedToCart = true
            }
        }
    }
    
    func deleteFromCart() {
        service.deleteFromCart(position) {
            self.position.addedToCart = false  
        }
    }
}
