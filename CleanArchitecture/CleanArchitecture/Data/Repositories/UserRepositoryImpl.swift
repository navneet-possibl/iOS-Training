//
//  UserRepositoryImpl.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import Foundation

final class UserRepositoryImpl: UserRepository {

    static let defaultUsersEndpoint = "https://jsonplaceholder.typicode.com/users"

    private let apiClient: APIClientProtocol
    private let usersEndpoint: String

    init(
        apiClient: APIClientProtocol,
        usersEndpoint: String = UserRepositoryImpl.defaultUsersEndpoint
    ) {
        self.apiClient = apiClient
        self.usersEndpoint = usersEndpoint
    }

    func getUsers() async throws -> [User] {

        guard let url = URL(string: usersEndpoint),
              !usersEndpoint.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            throw APIError.invalidURL
        }

        let response: [UserDTO] = try await apiClient.get(
            [UserDTO].self,
            from: url
        )

        return response.map {
            $0.toDomain()
        }
    }
}
