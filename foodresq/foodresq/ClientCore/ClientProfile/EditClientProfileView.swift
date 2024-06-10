//
//  EditClientProfileView.swift
//  foodresq
//
//  Created by Дасаева София  on 02.06.2024.
//

import SwiftUI

struct EditClientProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditClientProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditClientProfileViewModel(user: user))
    }
    var body: some View {
        VStack{
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
                    Text("Имя")
                    Spacer()
                    TextField("Введите ваше имя", text: $viewModel.name)
                }
                Divider()
            }
        }
    }
}

#Preview {
    EditClientProfileView(user: User.MOCK_USERS[5])
}
