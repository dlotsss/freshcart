//
//  BuyNowCell.swift
//  foodresq
//
//  Created by Дасаева София  on 30.05.2024.
//

import SwiftUI
import Kingfisher

struct BuyNowCell: View {
    @ObservedObject var viewModel: BuyNowCellModel
    
    init(position: Position) {
        self.viewModel = BuyNowCellModel(position: position)
    }
    
    var body: some View {
        VStack{
            HStack{
                if let user = viewModel.position.user {
                    //ProfileImageView(user: user)
                    Text(user.username)
                }
            }
            KFImage(URL(string: viewModel.position.imageUrl)).resizable().frame(width: 180, height: 180)
            Text(viewModel.position.foodName)
            Text("₸ \(viewModel.position.price)")
            if viewModel.position.quantity > 0 {
                Text("Осталось всего \(viewModel.position.quantity)")
                Button(action: {
                    (viewModel.position.addedToCart ?? false) ?  viewModel.deleteFromCart() : viewModel.addToCart()
                }) {
                    HStack{
                        Image(systemName: (viewModel.position.addedToCart ?? false) ?  "checkmark" : "plus")
                        (viewModel.position.addedToCart ?? false) ?  Text("В корзине") : Text("Добавить в корзину")
                    }
                }
            } else {
                Text("Уже закончилось")
            }
        }
    }
}

#Preview {
    BuyNowCell(position: Position.MOCK_POSITIONS[0])
}
