//
//  BuyNowView.swift
//  foodresq
//
//  Created by Дасаева София  on 30.05.2024.
//

import SwiftUI

struct BuyNowView: View {
    @ObservedObject var viewModel = BuyNowViewModel()
    
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.positions) { position in
                    BuyNowCell(position: position)
                } 
            }.background(Color(lightGreyColor)).background(ignoresSafeAreaEdges: .all)
        }
    }
}

#Preview {
    BuyNowView()
}
