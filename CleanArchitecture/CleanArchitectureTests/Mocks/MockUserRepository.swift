//
//  MockUserRepository.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//


import Foundation
@testable import CleanArchitecture

final class MockUserRepository: UserRepository {

    var users: [User] = []
    var error: Error?

    private(set) var getUsersCalled = false

    func getUsers() async throws -> [User] {

        getUsersCalled = true

        if let error {
            throw error
        }

        return users
    }
}
