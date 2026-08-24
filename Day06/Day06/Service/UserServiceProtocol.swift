//
//  UserServiceProtocol.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//
import Foundation

protocol UserServiceProtocol {
    func fetchUser() async throws -> User
}

final class UserService: UserServiceProtocol {

    func fetchUser() async throws -> User {
        try await Task.sleep(for: .seconds(1))

        return User(
            id: 1,
            name: "Navneet",
            email: "nav@yopmail.com"
        )
    }
}
