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
    
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
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
                        }.tint(.black)
                    }
                }
            }.fullScreenCover(isPresented: $showEditProfile , content: {
                EditProfileView(user: user)
            }).tint(Color(blueColor))
            .navigationTitle("Профиль").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CurrentRestaurantProfileView(user: User.MOCK_USERS[0])
}
