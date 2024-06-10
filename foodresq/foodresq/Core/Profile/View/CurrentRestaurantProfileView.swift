//
//  CurrentRestaurantProfileView.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import SwiftUI

struct CurrentRestaurantProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showEditProfile = false
    @State private var positionsUpdated = false
    let user: User
    var body: some View {
        NavigationStack{
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
                    
                    HStack{
                        Image(systemName: "arrow.left.to.line.square")
                        Button(action: {
                            Task {
                                await viewModel.signOut()
                            }
                            print("i want to sign out")
                        }) {
                            SettingRowView(title: "Выйти", tintColor: Color(.systemGray))
                        }
                    }
                }
            }.fullScreenCover(isPresented: $showEditProfile , content: {
                EditProfileView(user: user)
            })
            .navigationTitle("Профиль").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CurrentRestaurantProfileView(user: User.MOCK_USERS[0])
}
