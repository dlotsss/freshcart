//
//  RegistrationView.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import SwiftUI

struct RegistrationView: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    @State private var name: String = ""
    @State private var login: String = ""
    @State private var password: String = ""
    @State var isPasswordVisible: Bool = true
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var isRest: Bool
    @State private var isRegistered = false

    var body: some View {
        VStack{
            Text("Создать аккаунт").font(.custom("Montserrat-Medium", size: 28)).padding(.bottom, 4).padding(.top, 128)
            Text("Создадим аккаунт вместе").font(.custom("Montserrat-Regular", size: 16)).frame(width: 247, height: 24).padding(.bottom, 24)
            
            VStack{
                InputView(text: $name,
                          title: "Вы",
                          placeholder: "Имя Фамилия")
                
                InputView(text: $login,
                          title: "Логин",
                          placeholder: "name@example.com").autocapitalization(.none)
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)){
                    InputView(text: $password,
                              title: "Пароль",
                              placeholder: "Введите свой пароль",
                              isSecureField: isPasswordVisible)
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    }.foregroundStyle(.black).padding(.trailing, 34)
                }
            }
            Button(action: {
                Task {
                    try await viewModel.createUser(withEmail: login, password: password, fullname: name, isRest: isRest)
                    if viewModel.userSession != nil {
                        isRegistered = true // Set isRegistered to true if registration is successful
                    }
                }
            }) {
                Text("Зарегестрироваться").font(.custom("Montserrat-Medium", size: 18))
            }.disabled(!formIsValid).padding(.horizontal, 69.5).padding(.vertical, 16).background(Color(blueColor)).foregroundColor(.white).cornerRadius(50).opacity(formIsValid ? 1.0 : 0.5).padding(.bottom, 146)
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Уже есть аккаунт?").font(.custom("Montserrat-Regular", size: 12)).foregroundStyle(Color(greyColor))
                    Text("Войти").font(.custom("Montserrat-Medium", size: 12))
                }
            }.foregroundStyle(.black).padding(.bottom, 50)
            if let currentUser = viewModel.currentUser {
                NavigationLink(destination: MainTabView(user: currentUser).navigationBarBackButtonHidden(true), isActive: $isRegistered) {
                    EmptyView()
                }
            }

        }.background(Color(lightGreyColor)).background(ignoresSafeAreaEdges: .all)
    }
}




extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !login.isEmpty && login.contains("@") && !password.isEmpty && password.count > 7 && !name.isEmpty
    }
}


