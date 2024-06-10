//
//  UploadPostView.swift
//  foodresq
//
//  Created by Дасаева София  on 31.05.2024.
//

import SwiftUI
import PhotosUI

struct UploadPositionView: View {
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
                }
                
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
                }
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
        }
        .onAppear(){
            imagePickerPresented.toggle()
            
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}
