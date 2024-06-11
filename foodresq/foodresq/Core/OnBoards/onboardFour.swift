//
//  onboardFour.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import SwiftUI

struct onboardFour: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    @State private var collectionName = ""
    @State private var isRestaurant = false
    @State private var isClient = false
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                ZStack{
                    Text("FOOD\nRESQ").font(.custom("Montserrat-Bold", size: 120)).foregroundColor(Color(lightGreyColor))
                    Image("logo").resizable().frame(width: 437, height: 400).padding(.trailing, 51).padding(.leading, 31)
                }
                VStack(alignment: .leading){
                    Text("Выберите").font(.custom("Montserrat-Medium", size: 16)).foregroundColor(.black)
                }.padding(.leading, -180)
                HStack{
                    Spacer()
                    NavigationLink(destination: LoginView(isRest: $isRestaurant).navigationBarBackButtonHidden(true), isActive: $isRestaurant){
                        EmptyView()
                    }
                    Button(action:{
                        collectionName = "restaurants"
                        isRestaurant = true
                    }){
                        Text("Я - заведение").font(.custom("Montserrat-Medium", size: 18))
                    }.padding(.horizontal, 32).padding(.vertical, 16).background(Color(blueColor)).foregroundColor(.white).cornerRadius(50)
                    
                    Spacer()
                    
                    
                    NavigationLink(destination: LoginView(isRest: $isRestaurant).tint(Color(blueColor)), isActive: $isClient){
                        EmptyView()
                    }
                    
                    
                    Button(action:{
                        collectionName = "users"
                        isClient = true
                    }){
                        Text("Я - клиент").font(.custom("Montserrat-Medium", size: 18))
                    }.padding(.horizontal, 32).padding(.vertical, 16).background(Color(blueColor)).foregroundColor(.white).cornerRadius(50)
                    
                    Spacer()
                }
                Spacer()
            }.tint(Color(blueColor))
        }
    }
}

#Preview {
    onboardFour()
}
