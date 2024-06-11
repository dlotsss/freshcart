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
    
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
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
            Spacer()
        }.tint(Color(blueColor))
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
