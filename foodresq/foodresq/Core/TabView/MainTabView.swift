//
//  RestaurantProfileTabView.swift
//  foodresq
//
//  Created by Дасаева София  on 30.05.2024.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    var body: some View {
        if user.isRest {
            TabView(selection: $selectedIndex){
                CurrentRestaurantProfileView(user: user).onAppear(){
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "person.fill")
                }.tag(0)
                
                UploadPositionView(tabIndex: $selectedIndex, tempUser: user).onAppear(){
                    selectedIndex = 1
                }.tabItem {
                    Image(systemName: "plus.app")
                }.tag(1)
            }
        }
        else {
            TabView{
                BuyNowView().tabItem {
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
            }
        }
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[5])
}
