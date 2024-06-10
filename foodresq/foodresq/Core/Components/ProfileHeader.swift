//
//  RestaurantProfileHeader.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import SwiftUI

struct ProfileHeader: View {
    let user: User
    @Binding var showEditProfile: Bool
    var body: some View {
        VStack{
            HStack{
               // ProfileImageView(user: user)
                if user.isCurrentUser {
                    Button(action: {
                        showEditProfile.toggle()
                    }) {
                        HStack{
                            Text("Изменить")
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
        }
    }
}


