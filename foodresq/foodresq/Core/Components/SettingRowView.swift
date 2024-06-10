//
//  SettingRowView.swift
//  foodresq
//
//  Created by Дасаева София  on 29.05.2024.
//

import SwiftUI

struct SettingRowView: View {
    let title: String
    let tintColor: Color
    var body: some View {
        HStack{
            Text(title)
        }
    }
}

#Preview {
    SettingRowView(title: "Palermo", tintColor: Color(.systemGray))
}
