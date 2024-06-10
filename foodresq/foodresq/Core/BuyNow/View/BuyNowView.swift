//
//  BuyNowView.swift
//  foodresq
//
//  Created by Дасаева София  on 30.05.2024.
//

import SwiftUI

struct BuyNowView: View {
    @ObservedObject var viewModel = BuyNowViewModel()
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.positions) { position in
                    BuyNowCell(position: position)
                } 
            }
        }
    }
}

#Preview {
    BuyNowView()
}
