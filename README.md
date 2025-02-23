# FreshCart 🛒  
**Reduce Food Waste in Kazakhstan | Swift & Firebase/Firestore Integration**  

A Swift-based iOS application integrated with Firebase Firestore to combat food waste in Kazakhstan by connecting restaurants with consumers for surplus food redistribution.

[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org/)
[![Firebase](https://img.shields.io/badge/Firebase-9.0-red.svg)](https://firebase.google.com/)

## Problem Statement  
40% of food in Kazakhstan is wasted annually, with 78% of discarded food still edible. FreshCart addresses this by connecting businesses with customers to sell near-expiry products at reduced prices.  

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

# Project File Structure

## 📂 freshcart
### 📂 Authentication
- **View**
  - `LoginView.swift`
  - `RegistrationView.swift`
- **ViewModel**
  - `AuthViewModel.swift`

### 📂 BuyNow
- **View**
  - `BuyNowCell.swift`
  - `BuyNowView.swift`
- **ViewModel**
  - `BuyNowCellModel.swift`
  - `BuyNowViewModel.swift`

### 📂 ClientCore
- **Cart**
  - `CartCellView.swift`
  - `CartCellViewModel.swift`
  - `CartView.swift`
  - `CartViewModel.swift`

### 📂 ClientProfile
- `ClientProfileView.swift`
- `EditClientProfileView.swift`
- `EditClientProfileViewModel.swift`

### 📂 Components
- `InputView.swift`
- `PositionView.swift`
- `ProfileHeader.swift`
- `ProfileImageView.swift`
- `SettingRowView.swift`

### 📂 Model
- `Position.swift`
- `User.swift`

### 📂 OnBoards
- `onboardFour.swift`
- `onboardOne.swift`
- `onboardThree.swift`
- `onboardTwo.swift`

### 📂 Profile
- **View**
  - `CurrentRestaurantProfileView.swift`
  - `EditProfileView.swift`
  - `profileRestaurant.swift`
- **ViewModel**
  - `EditProfileViewModel.swift`
  - `profileRestaurantModel.swift`

### 📂 RestaurantsList
- `RestaurantsView.swift`
- `RestaurantsViewModel.swift`

### 📂 Root
- **View**
  - `ContentView.swift`

### 📂 Service
- `ImageUploader.swift`
- `PositionService.swift`
- `UserService.swift`

### 📂 TabView
- `MainTabView.swift`

### 📂 UploadPosition
- `UploadPositionView.swift`
- `UploadPositionViewModel.swift`

