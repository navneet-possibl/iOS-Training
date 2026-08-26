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

    @Published private(set) var state: UserViewState = .idle

    private let userService: any UserServiceProtocol

    init(userService: any UserServiceProtocol) {
        self.userService = userService
    }

    func fetchUser(id: Int) async {

        state = .loading

        do {
            let user = try await userService.fetchUser(id: id)

            state = .loaded(user)

        } catch {
            state = .failed(
                error.localizedDescription
            )
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
