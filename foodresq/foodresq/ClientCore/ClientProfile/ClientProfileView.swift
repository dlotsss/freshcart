//
//  ClientProfileView.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import SwiftUI

struct ClientProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showEditProfile = false
    let user: User
    var body: some View {
        VStack {
            ProfileHeader(user: user, showEditProfile: $showEditProfile)
            List{
                Section("Никнейм") {
                    SettingRowView(title: user.username, tintColor: Color(.systemGray))
                }
                
                if let name = user.name  {
                    Section("Имя") {
                        SettingRowView(title: name, tintColor: Color(.systemGray))
                    }
                }
                
                Section("Логин") {
                    SettingRowView(title: user.login, tintColor: Color(.systemGray))
                }
                
                HStack{
                    Image(systemName: "arrow.left.to.line.square")
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        SettingRowView(title: "Выйти", tintColor: Color(.systemGray))
                    }
                }
            }
        }.fullScreenCover(isPresented: $showEditProfile , content: {
            EditClientProfileView(user: user)
        })
        .navigationTitle("Профиль").navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ClientProfileView(user: User.MOCK_USERS[5])
}
