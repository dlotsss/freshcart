//
//  EditProfileView.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack{
            //toolbar
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Отменить")
                    }
                    
                    Spacer()
                    
                    Text("Изменить профиль")
                    
                    Spacer()
                    
                    Button(action: {  
                        Task{
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }) {
                        Text("Сохранить")
                    }
                }
            }
            Divider()
            
            //edit profile pic
//            PhotosPicker(selection: $viewModel.selectedImage){
//                VStack{
//                    if let image = viewModel.profileImage {
//                        image.resizable().frame(width: 80, height: 80)
//                    } else {
//                        ProfileImageView(user: viewModel.user)
//                    }
//                    Text("Изменить аватар")
//                    
//                    Divider()
//                }
//            }
            
            // edit profile info
            VStack{
                HStack{
                    Text("Название")
                    Spacer()
                    TextField("Введите название ресторана", text: $viewModel.name)
                }
                Divider()
                HStack{
                    Text("Описание")
                    Spacer()
                    TextField("Введите описание ресторана", text: $viewModel.description, axis: .vertical)
                }
            }
        }
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
