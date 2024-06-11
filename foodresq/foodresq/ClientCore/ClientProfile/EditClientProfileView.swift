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
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
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
            }.tint(Color(blueColor))
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
