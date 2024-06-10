//
//  ImageUploader.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename )")
        do{
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch{
            print("failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
