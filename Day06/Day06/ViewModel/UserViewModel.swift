//
//  UserViewModel.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//

import Combine
import Foundation

@MainActor
final class UserViewModel: ObservableObject {

    @Published private(set) var user: User?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
  //  private let service = UserService() - bad example
    
    
    func fetchUser() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            user = try await userService.fetchUser()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// DATA FLOW
//User taps "Load User"
//        ↓
//View receives action
//        ↓
//View calls ViewModel
//        ↓
//ViewModel sets isLoading = true
//        ↓
//@Published notifies View
//        ↓
//View shows ProgressView
//        ↓
//ViewModel calls Service
//        ↓
//Service fetches data
//        ↓
//ViewModel receives User model
//        ↓
//@Published user is updated
//        ↓
//SwiftUI detects state change
//        ↓
//View automatically updates
