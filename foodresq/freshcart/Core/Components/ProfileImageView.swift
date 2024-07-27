//
//  ProfileImageView.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    let user: User
    var body: some View {
        if let profileImageURL = user.profileImage {
            KFImage(URL(string: profileImageURL))
               .resizable()
               .frame(width: 80, height: 80).clipShape(Rectangle())
        } else {
            Image(systemName: "person.circle.fill").resizable().scaledToFill().frame(width: 80, height: 80)
        }
    }
}

#Preview {
    ProfileImageView(user: User.MOCK_USERS[0])
}
