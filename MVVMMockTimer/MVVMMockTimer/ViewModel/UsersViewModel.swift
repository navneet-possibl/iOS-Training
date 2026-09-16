//
//  UsersViewModel.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//

import Foundation
import Observation
import Combine

@MainActor
@Observable
final class UsersViewModel {
    enum State {
        case idle
        case loading
        case loaded([User])
        case failed(String)
    }

    private let service: any UserServicing

    private(set) var state: State = .idle

    init(service: any UserServicing) {
        self.service = service
    }

    var users: [User] {
        if case .loaded(let users) = state {
            return users
        }
        return []
    }

    var errorMessage: String? {
        if case .failed(let message) = state {
            return message
        }
        return nil
    }

    var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }

    func loadUsers() async {
        state = .loading

        do {
            let users = try await service.fetchUsers()
            state = .loaded(users)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
