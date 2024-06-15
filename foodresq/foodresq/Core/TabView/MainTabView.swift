//
//  MainTabView.swift
//  foodresq
//
//  Created by Дасаева София  on 30.05.2024.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
    var body: some View {
        if user.isRest {
            TabView(selection: $selectedIndex){
                CurrentRestaurantProfileView(user: user).onAppear(){
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "person.circle")
                }.tag(0)
                
                UploadPositionView(tabIndex: $selectedIndex, tempUser: user).onAppear(){
                    selectedIndex = 1
                }.tabItem {
                    Image(systemName: "plus.circle")
                }.tag(1)
            }.tint(Color(blueColor))
        }
        else {
            TabView{
                BuyNowView(user: user).tabItem {
                    Image(systemName: "fork.knife.circle")
                }.tag(0)
                RestaurantsView().tabItem {
                    Image(systemName: "building.columns.circle")
                }.tag(1)
                CartView(user: user).tabItem {
                    Image(systemName: "cart.circle")
                }.tag(2)
                ClientProfileView(user: user).tabItem {
                    Image(systemName: "person.crop.circle")
                }.tag(3)
            }.tint(Color(blueColor))
        }
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[5])
}
