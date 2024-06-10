//
//  EditProfileViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import PhotosUI
import SwiftUI
import Firebase

@MainActor
class EditProfileViewModel: ObservableObject {
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
        if let description = user.description{
            self.description = description
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
        
        if !description.isEmpty && user.description != description {
            data["description"] = description
            print(data)
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("restaurants").document(user.id).updateData(data)
        }
    }
}
