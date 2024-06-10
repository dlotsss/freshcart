//
//  RestaurantsView.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import SwiftUI

struct RestaurantsView: View {
    @State private var seacrhText = ""
    @StateObject var viewModel = RestaurantsViewModel()
    
    var filteredUsers: [User] {
            if seacrhText.isEmpty {
                return viewModel.users
            } else {
                return viewModel.users.filter { $0.username.lowercased().contains(seacrhText.lowercased()) }
            }
        }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack{
                    ForEach (viewModel.users) { user in
                        NavigationLink(destination: profileRestaurant(user: user)) {
                                HStack {
                                    Image(user.profileImage ?? "")
                                    Text(user.username)
                                }
                            }
                    }
                }.searchable(text: $seacrhText, prompt: "Поиск...")
            }
        }
        .navigationTitle ("Заведения").navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RestaurantsView()
}
