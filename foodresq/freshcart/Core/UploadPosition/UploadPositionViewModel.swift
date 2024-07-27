//
//  UploadPositionViewModel.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPositionViewModel: ObservableObject{
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var positionImage: Image?
    
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.positionImage = Image(uiImage: uiImage )
    }
    
    func uploadPosition(foodName: String, price: Int, quantity: Int) async throws{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uiImage = uiImage else {return}
        let positionRef = Firestore.firestore().collection("positions").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else {return}
        let position = Position(id: positionRef.documentID, ownerUid: uid, foodName: foodName, price: price, imageUrl: imageUrl, quantity: quantity)
        guard let encodedPosition = try? Firestore.Encoder().encode(position) else {return}
        
        try await positionRef.setData(encodedPosition)
    }
    
}
