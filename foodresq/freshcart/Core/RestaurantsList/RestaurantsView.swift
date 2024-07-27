

import SwiftUI

struct RestaurantsView: View {
    var greyColor = #colorLiteral(red: 0.5131264925, green: 0.5556035042, blue: 0.5779691339, alpha: 1)
    var lightGreyColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    var blueColor = #colorLiteral(red: 0.3568627451, green: 0.6196078431, blue: 0.8823529412, alpha: 1)
    var lightBlueColor = #colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 0.968627451, alpha: 1)
    
    @State private var searchText = ""
    @StateObject var viewModel = RestaurantsViewModel()
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { $0.username.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Поиск...", text: $searchText).padding(.vertical, 8).padding(.leading, 14)
                   .background(Color(lightGreyColor))
                   .cornerRadius(50).padding(.horizontal, 20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(filteredUsers) { user in
                            NavigationLink(destination: profileRestaurant(user: user)) {
                                HStack {
                                    // Image(user.profileImage?? "")
                                    Text(user.username).font(.custom("Montserrat-Bold", size: 28)).frame(width: 335, height: 120).background(RoundedRectangle(cornerRadius: 16).fill(.white))
                                }
                            }
                        }
                    }
                }
               .background(Color(lightGreyColor))
               .background(ignoresSafeAreaEdges: .all)
            }
           .navigationTitle("Заведения")
           .navigationBarTitleDisplayMode(.inline)
           .tint(.black)
        }
    }
}
