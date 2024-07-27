//
//  LoginView.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.//



// I'M EDITING THIS ONE!!!!!
//

import SwiftUI

struct LoginView: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var login = ""
    @State private var password = ""
    @State var isPasswordVisible: Bool = true
    @Binding var isRest: Bool
    @State private var isLoggedIn = false
    var body: some View {
        NavigationStack{
            VStack{
                Text("Снова привет!").font(.custom("Montserrat-Medium", size: 28)).padding(.bottom, 4).padding(.top, 128)
                Text("С возвращением! Мы скучали \nпо тебе!").font(.custom("Montserrat-Regular", size: 16)).frame(width: 267, height: 48).multilineTextAlignment(.center).padding(.bottom, 24)
                
                VStack(alignment: .leading){
                    InputView(text: $login,
                              title: "Логин",
                              placeholder: "name@example.com").autocapitalization(.none).padding(.bottom, 16)
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .lastTextBaseline)){
                        InputView(text: $password,
                                  title: "Пароль",
                                  placeholder: "Введите свой пароль",
                                  isSecureField: isPasswordVisible)
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        }.foregroundStyle(.black).padding(.trailing, 34)
                    }.padding(.bottom, 34)
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
                    Text("Войти").font(.custom("Montserrat-Medium", size: 18))
                }.disabled(!formIsValid).padding(.horizontal, 135.5).padding(.vertical, 16).background(Color(blueColor)).foregroundColor(.white).cornerRadius(50).opacity(formIsValid ? 1.0 : 0.5).padding(.bottom, 232)
                
                NavigationLink {
                    RegistrationView(isRest: $isRest).navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text("Еще нет аккаунта?").font(.custom("Montserrat-Regular", size: 12)).foregroundStyle(Color(greyColor))
                        Text("Создать аккаунт").font(.custom("Montserrat-Medium", size: 12))
                    }
                }.foregroundStyle(.black).padding(.bottom, 50)
                if let currentUser = viewModel.currentUser {
                    NavigationLink(destination: MainTabView(user: currentUser).navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                }

            }
            .background(Color(lightGreyColor)).background(ignoresSafeAreaEdges: .all)
        }.tint(Color(blueColor))
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !login.isEmpty && login.contains("@") && !password.isEmpty && password.count > 7
    }
}
