//
//  RegistrationView.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import SwiftUI

struct RegistrationView: View {
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
            Text("Создать аккаунт")
            Text("Создадим аккаунт вместе")
            VStack{
                InputView(text: $name,
                          title: "Вы",
                          placeholder: "Имя Фамилия")
                InputView(text: $login,
                          title: "Логин",
                          placeholder: "name@example.com").autocapitalization(.none)
                HStack{
                    InputView(text: $password,
                              title: "Пароль",
                              placeholder: "Введите свой пароль",
                              isSecureField: isPasswordVisible)
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    }
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
                Text("Зарегестрироваться")
            }.disabled(!formIsValid).opacity(formIsValid ? 1.0 : 0.5)
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Уже есть аккаунт?")
                    Text("Войти")
                }
            }
            
            NavigationLink(destination: MainTabView(user: viewModel.currentUser!), isActive: $isRegistered) {
                EmptyView()
            }
        }
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !login.isEmpty && login.contains("@") && !password.isEmpty && password.count > 7 && !name.isEmpty
    }
}


