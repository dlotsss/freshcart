//
//  profileRestaurant.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import SwiftUI

struct profileRestaurant: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showEditProfile = false
    let user: User
      
    var body: some View {
//            if let user = viewModel.currentUser {
        VStack {
            ProfileHeader(user: user, showEditProfile: $showEditProfile)
            List{
                Section("Название") {
                    SettingRowView(title: user.username, tintColor: Color(.systemGray))
                }
                Section("Логин") {
                    SettingRowView(title: user.login, tintColor: Color(.systemGray))
                }
                if let description = user.description {
                    Section("Описание") {
                        SettingRowView(title: description, tintColor: Color(.systemGray))
                    }
                }
             
                Section("Позиции") {
                    PositionView(user: user)
                }
                
            }
        }.fullScreenCover(isPresented: $showEditProfile , content: {
            EditProfileView(user: user)
        })
        .navigationTitle("Профиль").navigationBarTitleDisplayMode(.inline)
            //}
    }
}

#Preview {
    profileRestaurant(user: User.MOCK_USERS[0])
}
