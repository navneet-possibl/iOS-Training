//
//  UserService.swift
//  Day06
//
//  Created by HIMANK on 25/08/26.
//


import Foundation

final class UserService: UserServiceProtocol {

    private let apiClient: any APIClientProtocol

    init(apiClient: any APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchUser(id: Int) async throws -> User {

        let endpoint = UserEndpoint.user(id: id)

        return try await apiClient.request(
            endpoint: endpoint,
            responseType: User.self
        )
    }
}
