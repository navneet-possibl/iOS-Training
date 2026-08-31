//
//  GetUsersUseCase.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import Foundation

protocol GetUsersUseCase {
    func execute() async throws -> [User]
}

final class GetUsersUseCaseImpl: GetUsersUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() async throws -> [User] {
        let users = try await repository.getUsers()

        // Business rule belongs in Domain, not in the View.
        return users.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }
}
