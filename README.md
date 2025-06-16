# FreshCart 🛒  
**Reduce Food Waste in Kazakhstan | Swift & Firebase/Firestore Integration**  

A Swift-based iOS application integrated with Firebase Firestore to combat food waste in Kazakhstan by connecting restaurants with consumers for surplus food redistribution.

[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org/)
[![Firebase](https://img.shields.io/badge/Firebase-9.0-red.svg)](https://firebase.google.com/)

## Problem Statement  
In Kazakhstan 1.3 million tons of food is wasted annually, it is 40% of all food produces. 78% of discarded food is still edible, though. Still, there are 750k people who are below the poverty line in our country. In the world, when 1.3 billion tons of food is wasted, it creates 9.3 billion tons of CO2 emissions because 1kg of wasted food produces 2.5 kg of CO2. Thus, if food waste were a country, it would be the 3rd largest greenhouse gas emitter. TheFreshCart addresses this by connecting businesses with customers to sell near-expiry products at reduced prices. 

## Solution  
A **triple-win ecosystem** (business, customer, environment) built with:  
- **iOS App (Swift)**: Consumer-facing platform for purchasing discounted food.  
- **Firebase/Firestore**: Real-time database, authentication, and cloud services.  
- **Web Platform**: Business portal for managing inventory (not included in this repo).

## 🌱 Key Features

- **Real-time Cart Management**
  - Firebase-powered cart synchronization
  - Instant quantity updates
  - Purchase history tracking
  
- **User Profile System**
  - Secure authentication with Firebase Auth
  - Editable profile information
  - Profile image upload capability

- **Restaurant Integration**
  - Menu management for food establishments
  - Expiry tracking for food items
  - Sales analytics dashboard

## 🛠️ Technical Stack

- **Frontend**: SwiftUI
- **Backend**: Firebase Firestore, Authentication, Storage
- **Architecture**: MVVM
- **Dependency Management**: Swift Package Manager/CocoaPods
- **Tools**: Xcode 14+, iOS 16+

## 📲 Installation

### Prerequisites
- Xcode 14+
- iOS 16+ simulator or device
- Firebase project setup

# FreshCart File Structure

```
📦 FreshCart
┣ 📂 Authentication
┃ ┣ 📂 View
┃ ┃ ┣ 📜 LoginView.swift
┃ ┃ ┗ 📜 RegistrationView.swift
┃ ┗ 📂 ViewModel
┃ ┃ ┗ 📜 AuthViewModel.swift
┣ 📂 BuyNow
┃ ┣ 📂 View
┃ ┃ ┣ 📜 BuyNowCell.swift
┃ ┃ ┗ 📜 BuyNowView.swift
┃ ┗ 📂 ViewModel
┃ ┃ ┣ 📜 BuyNowCellModel.swift
┃ ┃ ┗ 📜 BuyNowViewModel.swift
┣ 📂 ClientCore
┃ ┗ 📂 Cart
┃ ┃ ┣ 📜 CartCellView.swift
┃ ┃ ┣ 📜 CartCellViewModel.swift
┃ ┃ ┣ 📜 CartView.swift
┃ ┃ ┗ 📜 CartViewModel.swift
┣ 📂 ClientProfile
┃ ┣ 📜 ClientProfileView.swift
┃ ┣ 📜 EditСlientProfileView.swift
┃ ┗ 📜 EditСlientProfileViewModel.swift
┣ 📂 Components
┃ ┣ 📜 InputView.swift
┃ ┣ 📜 PositionView.swift
┃ ┣ 📜 ProfileHeader.swift
┃ ┣ 📜 ProfileImageView.swift
┃ ┗ 📜 SettingRowView.swift
┣ 📂 Model
┃ ┣ 📜 Position.swift
┃ ┗ 📜 User.swift
┣ 📂 OnBoards
┃ ┣ 📜 onboardFour.swift
┃ ┣ 📜 onboardOne.swift
┃ ┣ 📜 onboardThree.swift
┃ ┗ 📜 onboardTwo.swift
┣ 📂 Profile
┃ ┣ 📂 View
┃ ┃ ┣ 📜 CurrentRestaurantProfileView.swift
┃ ┃ ┣ 📜 EditProfileView.swift
┃ ┃ ┗ 📜 profileRestaurant.swift
┃ ┗ 📂 ViewModel
┃ ┃ ┣ 📜 EditProfileViewModel.swift
┃ ┃ ┗ 📜 profileRestaurantModel.swift
┣ 📂 RestaurantsList
┃ ┣ 📜 RestaurantsView.swift
┃ ┗ 📜 RestaurantsViewModel.swift
┣ 📂 Root
┃ ┗ 📂 View
┃ ┃ ┗ 📜 ContentView.swift
┣ 📂 Service
┃ ┣ 📜 ImageUploader.swift
┃ ┣ 📜 PositionService.swift
┃ ┗ 📜 UserService.swift
┣ 📂 TabView
┃ ┗ 📜 MainTabView.swift
┗ 📂 UploadPosition
┃ ┣ 📜 UploadPositionView.swift
┃ ┗ 📜 UploadPositionViewModel.swift
```
### 1. Role-Based Authentication System
**AuthViewModel.swift** - Core authentication logic:
``` class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @MainActor
    func signIn(withEmail login: String, password: String, isRest: Bool) async throws {
        let result = try await Auth.auth().signIn(withEmail: login, password: password)
        self.userSession = result.user
        try await loadUserData()
    }
    
    @MainActor
    func createUser(withEmail login: String, password: String, fullname: String, isRest: Bool) async throws {
        let result = try await Auth.auth().createUser(withEmail: login, password: password)
        await updateUserData(uid: result.user.uid, username: fullname, login: login, isRest: isRest)
    }
}
```

### 2. User Profile Management
**User.swift** - Data model:

```
struct User: Identifiable, Hashable, Codable {
    let id: String
    let username: String
    let login: String
    let isRest: Bool
    var name: String?
    var profileImage: String?
    
    static var MOCK_USERS: [User] = [
        .init(id: UUID().uuidString, username: "Palermo", login: "palermo@test.com", isRest: true),
        .init(id: UUID().uuidString, username: "Client", login: "client@test.com", isRest: false)
    ]
}
```

### 3. Real-Time Cart System
**CartViewModel.swift** - Inventory synchronization:

```
class CartViewModel: ObservableObject {
    @Published var positions = [Position]()
    private var listener: ListenerRegistration?
    
    init(user: User) {
        setupRealTimeUpdates(user: user)
    }
    
    private func setupRealTimeUpdates(user: User) {
        let db = Firestore.firestore()
        let cartRef = db.collection("restaurants").document(user.id).collection("user-cart")
        
        listener = cartRef.addSnapshotListener { snapshot, _ in
            Task { try await self.fetchCartPositions(uid: user.id) }
        }
    }
    
    func processCheckout() async throws {
        let batch = Firestore.firestore().batch()
        for position in positions {
            let ref = Firestore.firestore().collection("positions").document(position.id)
            position.quantity > 1 ? 
                batch.updateData(["quantity": FieldValue.increment(-1)], forDocument: ref) :
                batch.deleteDocument(ref)
        }
        try await batch.commit()
    }
}
```

### 4. Product Management
**Position.swift** - Data model:

```
struct Position: Identifiable, Codable, Hashable {
    let id: String
    let ownerUid: String
    let foodName: String
    let price: Int
    let imageUrl: String
    let quantity: Int
    var addedToCartID: [String]? = []
    
    static var MOCK_POSITIONS: [Position] = [
        .init(id: UUID().uuidString, ownerUid: "1", foodName: "Margherita Pizza", 
              price: 1700, imageUrl: "pizza", quantity: 5)
    ]
}
```
### 5. Image Handling Service
**ImageUploader.swift** - Firebase Storage integration:
```
class ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        let _ = try await ref.putDataAsync(imageData)
        return try await ref.downloadURL().absoluteString
    }
}
```

### 6. Firestore Architecture
```
// Collections Structure
restaurants/
  ├── {restaurantID}
  │   ├── positions/
  │   │   └── {positionID}
  │   │       ├── foodName: string
  │   │       ├── price: number
  │   │       ├── quantity: number
  │   │       └── imageUrl: string
  │   └── user-cart/
  │       └── {userID}
  │           └── positions: array[string]
  └── users/
      ├── id: string
      ├── isRest: boolean
      └── profileImage: string
```

![FreshCart Demo](./imgs/demo-freshcart.gif)
