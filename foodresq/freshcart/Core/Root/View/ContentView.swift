//
//  ContentView.swift
//  foodresq
//
//  Created by Дасаева София  on 28.05.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                if let currentUser = viewModel.currentUser{
                    MainTabView(user: currentUser)
                }
            }else {
                onboardOne()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a mock AuthViewModel instance
        let mockViewModel = AuthViewModel()
        
        // Provide the mock viewModel as an environment object
        ContentView().environmentObject(mockViewModel)
    }
}
