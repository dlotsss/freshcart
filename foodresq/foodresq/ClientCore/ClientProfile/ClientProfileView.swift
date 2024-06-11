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
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
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
                        SettingRowView(title: "Выйти", tintColor: Color(.black))
                    }.tint(.black)
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
