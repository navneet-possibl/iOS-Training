//
//  UserViewModel.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import Foundation
import Combine

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let getUsers: GetUsersUseCase

    init(getUsers: GetUsersUseCase) {
        self.getUsers = getUsers
    }

    func loadUsers() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            users = try await getUsers.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
