//
//  UploadPostView.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import SwiftUI
import PhotosUI

struct UploadPositionView: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
    @State private var foodName = ""
    @State private var price = ""
    @State private var quantity = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPositionViewModel()
    @Binding var tabIndex: Int
    @State var tempUser: User
    
    var body: some View {
        VStack{
            //buttons
            HStack{
                Button(action: {
                    foodName = ""
                    price = ""
                    viewModel.selectedImage = nil
                    viewModel.positionImage = nil
                    tabIndex = 0
                }) {
                    Text("Отменить")
                }.tint(Color(blueColor))
                
                Text("Новая позиция")
                
                Button(action: {
                    Task{
                        @StateObject var anotherViewModel = profileRestaurantModel(user: tempUser)
                        try await anotherViewModel.fetchUserPositions()
                        try await viewModel.uploadPosition(foodName: foodName, price: Int(price) ?? 0, quantity: Int(quantity) ?? 0)
                        foodName = ""
                        price = ""
                        quantity = ""
                        viewModel.selectedImage = nil
                        viewModel.positionImage = nil
                        tabIndex = 0
                        
                    }
                    
                }) {
                    Text("Добавить")
                }.tint(Color(blueColor))
            }
            //post image, foodname, price
            VStack{
                if let image = viewModel.positionImage {
                    image.resizable().frame(width: 200, height: 200)
                }
                TextField("Введите название блюда", text: $foodName)
                TextField("Введите цену блюда", text: $price)
                TextField("Введите количество оставшихся блюд", text: $quantity)
                
            }
        }.background(Color(lightGreyColor)).background(ignoresSafeAreaEdges: .all)
            .tint(Color(blueColor))
        .onAppear(){
            imagePickerPresented.toggle()
            
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}
