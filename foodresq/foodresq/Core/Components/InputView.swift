//
//  InputView.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import SwiftUI

struct InputView: View {
    var lightGreyColor = #colorLiteral(red: 0.9725490196, green: 0.9764705882, blue: 0.9803921569, alpha: 1)
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var body: some View {
        VStack(alignment: .leading){
            Text(title).font(.custom("Montserrat-Medium", size: 16)).padding(.leading, 20)
            if isSecureField {
                SecureField(placeholder, text: $text).font(.custom("Montserrat-Regullar", size: 14)).padding(.leading, 14).padding(.vertical, 16).padding(.trailing, 136).background(.white).cornerRadius(50).padding(.leading, 20).padding(.trailing, 20)
            } else {
                TextField(placeholder, text: $text).font(.custom("Montserrat-Regullar", size: 14)).padding(.leading, 14).padding(.vertical, 16).padding(.trailing, 136).background(.white).cornerRadius(50).padding(.leading, 20).padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Логин", placeholder: "name@example.com")
}
