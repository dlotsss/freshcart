//
//  CartCellView.swift
//  foodresq
//
//  Created by Дасаева София  on 03.06.2024.
//

import SwiftUI
import Kingfisher

struct CartCellView: View {
    @ObservedObject var viewModel: CartCellViewModel
    
    init(position: Position) {
        self.viewModel = CartCellViewModel(position: position)
    }
    
    var body: some View {
        VStack{
            HStack{
                KFImage(URL(string: viewModel.position.imageUrl)).resizable().frame(width: 180, height: 180)
                VStack(alignment: .leading){
                    Text(viewModel.position.foodName)
                    Text("₸ \(viewModel.position.price)")
                }
                Spacer()
                Button(action: {
                    viewModel.deleteFromCart()
                }) {
                    Image(systemName: "trash.fill")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CartCellView(position: Position.MOCK_POSITIONS[0])
}
