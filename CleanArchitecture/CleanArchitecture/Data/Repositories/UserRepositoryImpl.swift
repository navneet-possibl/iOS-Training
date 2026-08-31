//
//  UserRepositoryImpl.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func getUsers() async throws -> [User] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let response: [UserDTO] = try await apiClient.get([UserDTO].self, from: url)

        return response.map { $0.toDomain()}
    }
}
