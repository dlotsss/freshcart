//
//  RestaurantsViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 01.06.2024.
//

import Foundation

class RestaurantsViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var filteredUsers = [User]()

    
    init () {
        Task{
            try await fetchAllUsers()
        }
    }
    
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
