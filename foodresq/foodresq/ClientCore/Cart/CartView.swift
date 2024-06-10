//
//  CartView.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: CartViewModel(user: user))
    }
    func test() {
        print(1)
    }
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.positions) { position in
                    CartCellView(position: position)
                }.onAppear(perform: {
                    Task {try await viewModel.fetchPositions() }
                    print(viewModel.positions)
                })
            }
        }
    }
}

#Preview {
    CartView(user: User.MOCK_USERS[0])
}
