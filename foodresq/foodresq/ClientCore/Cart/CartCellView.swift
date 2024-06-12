//
//  CartCellView.swift
//  foodresq
//
//  Created by Дасаева София  on 03.06.2024.
//

import SwiftUI
import Kingfisher

struct CartCellView: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    @ObservedObject var viewModel: CartCellViewModel
    
    let user: User
    
    init(position: Position, user: User) {
        self.viewModel = CartCellViewModel(position: position, user: user)
        self.user = user
    }
    
    var body: some View {
        VStack{
            HStack{
                KFImage(URL(string: viewModel.position.imageUrl)).resizable().frame(width: 90, height: 90).padding(.leading, 20)
                VStack(alignment: .leading){
                    Text(viewModel.position.foodName).font(.custom("Montserrat-Medium", size: 16))
                    Text("₸ \(viewModel.position.price)").font(.custom("Montserrat-Medium", size: 14))
                }.padding(.leading, 20)
                Spacer()
                Button(action: {
                    viewModel.deleteFromCart()
                }) {
                    Image(systemName: "trash.fill").tint(Color(blueColor))
                }.padding(.trailing, 20)
            }
        }.padding(.bottom, 30)
    }
}

#Preview {
    CartCellView(position: Position.MOCK_POSITIONS[0], user: User.MOCK_USERS[5])
}
