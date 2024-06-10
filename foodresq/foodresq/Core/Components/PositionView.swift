//
//  PositionView.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import SwiftUI
import Kingfisher

struct PositionView: View {
    @StateObject var viewModel: profileRestaurantModel
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 17),
        .init(.flexible(), spacing: 17)
    ]
    init(user: User){
        self._viewModel = StateObject(wrappedValue: profileRestaurantModel(user: user))
    }
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(viewModel.positions) {
                position in
                VStack{
                    KFImage(URL(string: position.imageUrl)).resizable().frame(width: 90, height: 90)
                    Text(position.foodName)
                    Text("₸ \(position.price)")
                    Text("Осталось всего \(position.quantity)")
                }
            }
        }
    }
}

#Preview {
    PositionView(user: User.MOCK_USERS[0])
}
