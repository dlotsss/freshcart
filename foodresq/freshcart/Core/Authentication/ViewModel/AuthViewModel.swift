//
//  AuthViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import Combine

protocol AuthenticationFormProtocol{
    var formIsValid: Bool  { get }
}


class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isRest: Bool?
    
    init() {
        Task{
            try await loadUserData()
        }
    }
    
    @MainActor
    func signIn(withEmail login: String, password: String, isRest: Bool) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: login, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("Failed to log in with error \(error.localizedDescription) ")
        }
        
        
    }
    
    @MainActor
    func createUser(withEmail login: String, password: String, fullname: String, isRest: Bool) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: login, password: password)
            self.userSession = result.user
            await uploadUserData(uid: result.user.uid, username: fullname, login: login, isRest: isRest)
            print("uploaded user data")
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("signed out successfully")
        } catch {
            print("Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else {return}
        self.currentUser = try? await UserService.fetchUser(withUid: currentUid)
        self.isRest = self.currentUser?.isRest
    }
    
    private func uploadUserData(uid: String, username: String, login: String, isRest: Bool) async {
        let user = User(id: uid, username: username, login: login, isRest: isRest)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        try? await Firestore.firestore().collection("restaurants").document(user.id).setData(encodedUser)
         
    }

    
}
