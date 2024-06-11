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
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    if let user = viewModel.position.user {
                        //ProfileImageView(user: user)
                    Text(user.username).font(.custom("Montserrat-Medium", size: 20))
                    }
                }
                KFImage(URL(string: viewModel.position.imageUrl)).resizable().frame(width: 180, height: 180).padding(.bottom, 19)
                Text(viewModel.position.foodName).font(.custom("Montserrat-Regular", size: 18)).padding(.bottom, 3)
                Text("₸ \(viewModel.position.price)").font(.custom("Montserrat-Regular", size: 18)).padding(.bottom, 3)
                if viewModel.position.quantity > 0 {
                    Text("Осталось всего \(viewModel.position.quantity)").font(.custom("Montserrat-Regular", size: 18)).padding(.bottom, 19)
                   
                    if (viewModel.position.addedToCart ?? false) == true {
                        
                        Button(action: {
                            viewModel.deleteFromCart()
                        }) {
                            HStack{
                                Image(systemName:  "checkmark" )
                                Text("В корзине").font(.custom("Montserrat-Regular", size: 18))
                            }
                        } .foregroundColor(.white).frame(alignment: .center).padding(.horizontal, 25).padding(.vertical, 10).background(RoundedRectangle(cornerRadius: 15.0).fill(Color(blueColor)))
                        
                    } else {
                        
                        Button(action: {
                            viewModel.addToCart()
                        }) {
                            HStack{
                                Image(systemName: "plus")
                                Text("В корзину").font(.custom("Montserrat-Regular", size: 18))
                            }
                        }.foregroundColor(.black).frame(alignment: .center).padding(.horizontal, 25).padding(.vertical, 10).background(RoundedRectangle(cornerRadius: 15.0).stroke(lineWidth: 3).fill(Color(blueColor)))
                    }
                    
                    
                } else {
                    Text("Уже закончилось").font(.custom("Montserrat-Regular", size: 18)).padding(.bottom, 19)
                }
            }.padding(.vertical, 20).padding(.horizontal, 60).background(RoundedRectangle(cornerRadius: 25).fill(.white)).padding(.bottom, 40)
                
        }
    }
}

#Preview {
    BuyNowCell(position: Position.MOCK_POSITIONS[0])
}
