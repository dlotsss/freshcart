//
//  EditClientProfileViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class EditClientProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var profileImage: Image?
    
    @Published var name = ""
    @Published var description = ""
    
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        if let name = user.name {
            self.name = name
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage )
    }
    
    func updateUserData() async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage{
            let imageURL = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageURL"] = imageURL
        }
         
        if !name.isEmpty && user.name != name {
            data["name"] = name
            print(data)
            
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("restaurants").document(user.id).updateData(data)
        }
    }
}
