//
//  onboardOne.swift
//  foodresq
//
//  Created by Дасаева София  on 28.05.2024.
//

import SwiftUI

struct onboardOne: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                ZStack(alignment: .center){
                    Text("FOOD\nRESQ").font(.custom("Montserrat-Bold", size: 120)).foregroundColor(Color(lightGreyColor))
                    Image("pizza").resizable().frame(width: 200, height: 200)
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Заказывай и \nэкономь")
                        .font(.custom("Montserrat-Medium", size: 38)).padding(.bottom, 8)
                    Text("Есть разный выбор еды, которая осталась в конце дня").font(.custom("Montserrat-Medium", size: 20)).foregroundColor(Color(greyColor)).padding(.trailing, 60)
                }.padding(.leading, 20).padding(.bottom, 14)
                
                VStack{
                    HStack{
                        HStack(spacing: 8){
                            Text("___").font(.custom("Montserrat-Bold", size: 38)).foregroundColor(Color(blueColor)).padding(.leading, 40)
                            Text("_").font(.custom("Montserrat-Bold", size: 38)).foregroundColor(Color(lightBlueColor))
                            Text("_").font(.custom("Montserrat-Bold", size: 38)).foregroundColor(Color(lightBlueColor))
                        }
                        Spacer()
                        NavigationLink{
                            onboardTwo().navigationBarBackButtonHidden(true)
                        }label: {
                            Text("Далее").font(.custom("Montserrat-Medium", size: 18))
                        }.padding(.horizontal, 32).padding(.vertical, 16).background(Color(blueColor)).foregroundColor(.white).cornerRadius(50)
                    }
                }.padding(.trailing, 18)
                Spacer()
            }
        }
    }
}

#Preview {
    onboardOne()
}
