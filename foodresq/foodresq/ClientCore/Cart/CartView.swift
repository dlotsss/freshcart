//
//  CartView.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import SwiftUI

struct CartView: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
    @StateObject var viewModel: CartViewModel
    var user: User
    
    init(user: User) {
        self.user = user
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
                    Task {try await viewModel.fetchPositions(uid: self.user.id) }
                    print(viewModel.positions)
                })
                Spacer()
            }
        }.safeAreaInset(edge: .bottom) {
            Button(action: {
                viewModel.purchase(positons: viewModel.positions)
            }) {
                Text("Оплатить").font(.custom("Montserrat-Medium", size: 18))
            }.padding(.horizontal, 125).padding(.vertical, 16).background(Color(blueColor)).foregroundColor(.white).cornerRadius(50).frame(alignment: .bottom).padding(.bottom, 20)
        }
    }
}

#Preview {
    CartView(user: User.MOCK_USERS[0])
}
