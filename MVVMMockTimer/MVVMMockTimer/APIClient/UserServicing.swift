//
//  URLService.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//

import Foundation


protocol UserServicing {
    func fetchUsers() async throws -> [User]
}

struct UserService: UserServicing {
    private let apiClient: any APIClient
    private let endpoint: URL

    init(
        apiClient: any APIClient,
        endpoint: URL = URL(string: "https://jsonplaceholder.typicode.com/users")!
    ) {
        self.apiClient = apiClient
        self.endpoint = endpoint
    }

    func fetchUsers() async throws -> [User] {
        try await apiClient.get([User].self, from: endpoint)
    }
}
