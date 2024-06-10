//
//  LoginView.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import SwiftUI

struct LoginView: View {
    var lightGreyColor = #colorLiteral(red: 0.9725490196, green: 0.9764705882, blue: 0.9803921569, alpha: 1)
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var login = ""
    @State private var password = ""
    @State var isPasswordVisible: Bool = true
    @Binding var isRest: Bool 
    @State private var isLoggedIn = false
    var body: some View {
        NavigationStack{
            VStack{
                Text("Снова привет!").font(.custom("Montserrat-Medium", size: 28))
                Text("С возвращением! Мы скучали по тебе!").font(.custom("Montserrat-Regular", size: 16))
                
                VStack{
                    InputView(text: $login, 
                              title: "Логин",
                              placeholder: "name@example.com").autocapitalization(.none)
                    HStack(alignment: .center){
                        InputView(text: $password,
                                  title: "Пароль",
                                  placeholder: "Введите свой пароль",
                                  isSecureField: isPasswordVisible)
                        VStack{
                            Spacer()
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            }.foregroundStyle(.black).padding(.trailing, 14)
                        }
                    }
                }
                Button(action: {
                    Task {
                        try await viewModel.signIn(withEmail: login, password: password, isRest: isRest)
                        if viewModel.userSession != nil && viewModel.currentUser != nil {
                                isLoggedIn = true
                                print("logged in succesfully")
                            print(viewModel.currentUser)
                        } else {
                            print("can't login")
                        }
                        
                    }
                }) {
                    Text("Войти")
                }.disabled(!formIsValid).opacity(formIsValid ? 1.0 : 0.5)
                
                NavigationLink {
                    RegistrationView(isRest: $isRest).navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text("Еще нет аккаунта?")
                        Text("Создать аккаунт") 
                    }
                }
                if let currentUser = viewModel.currentUser {
                    NavigationLink(destination: MainTabView(user: currentUser).navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                } 

            }.background(Color(lightGreyColor))
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !login.isEmpty && login.contains("@") && !password.isEmpty && password.count > 7
    }
}
