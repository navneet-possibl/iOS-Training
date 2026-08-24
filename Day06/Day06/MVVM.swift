//# MVVM Architecture in iOS
//
//## What is MVVM?
//
//**MVVM** stands for:
//
//* **Model**
//* **View**
//* **ViewModel**


//MVVM is an architectural pattern used to separate UI, business logic, and data handling. It makes iOS applications easier to maintain, test, and scale.
//
//---
//
//## 1. Model
//
//The **Model** represents the application's data and business entities.
//
//```swift
//struct User: Codable, Identifiable {
//    let id: Int
//    let name: String
//    let email: String
//}
//```
//
//**Responsibilities:**
//
//* Data models
//* API response models
//* Database entities
//* Business data
//
//---
//
//## 2. View
//
//The **View** is responsible only for displaying the UI and receiving user interactions.
//
//```swift
//struct UserView: View {
//    
//    @StateObject private var viewModel = UserViewModel()
//    
//    var body: some View {
//        VStack {
//            Text(viewModel.user?.name ?? "Loading...")
//            
//            Button("Load User") {
//                viewModel.fetchUser()
//            }
//        }
//    }
//}
//```
//
//**The View should not contain:**
//
//* API calls
//* Complex business logic
//* Data transformation logic
//
//---
//
//## 3. ViewModel
//
//The **ViewModel** acts as a bridge between the View and Model.
//
//```swift
//@MainActor
//final class UserViewModel: ObservableObject {
//    
//    @Published var user: User?
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    func fetchUser() {
//        isLoading = true
//        
//        // Fetch and process data
//        
//        isLoading = false
//    }
//}
//```
//
//**Responsibilities:**
//
//* UI state management
//* Calling services/repositories
//* Business logic
//* Data transformation
//* Error handling
//
//---
//
//# MVVM Data Flow
//
//```text
//View
// ↓ User Action
//ViewModel
// ↓
//Repository / Service
// ↓
//API / Database
// ↓
//Model
// ↓
//ViewModel Updates State
// ↓
//View Automatically Updates
//```
//
//---
//
//# Important SwiftUI Property Wrappers
//
//### `@StateObject`
//
//Use when the View **creates and owns** the ViewModel.
//
//```swift
//@StateObject private var viewModel = UserViewModel()
//```
//
//### `@ObservedObject`
//
//Use when the ViewModel is **passed from another View**.
//
//```swift
//struct ChildView: View {
//    @ObservedObject var viewModel: UserViewModel
//}
//```
//
//### `@Published`
//
//Used inside the ViewModel to notify the View about changes.
//
//```swift
//@Published var users: [User] = []
//```
//
//---
//
//# Recommended Production Structure
//
//```text
//Feature
//├── Model
//│   └── User.swift
//├── View
//│   └── UserView.swift
//├── ViewModel
//│   └── UserViewModel.swift
//├── Service
//│   └── UserService.swift
//└── Repository
//    └── UserRepository.swift
//```
//
//---
//
//# MVVM Best Practices
//
//* Keep Views lightweight.
//* Do not make API calls directly from Views.
//* Keep ViewModels focused on presentation logic.
//* Use dependency injection.
//* Handle loading, success, empty, and error states.
//* Make ViewModels testable.
//* Use `@MainActor` when updating UI-related state.
//* Avoid putting navigation and networking logic directly inside Views.
//
//## Interview Definition
//
//> **MVVM separates the UI from business and presentation logic. The View displays data, the ViewModel manages UI state and coordinates business logic, and the Model represents the application's data. This separation improves maintainability, testability, and scalability.**
