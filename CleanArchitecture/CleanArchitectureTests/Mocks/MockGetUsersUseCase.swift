//
//  MockGetUsersUseCase.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//


import Foundation
@testable import CleanArchitecture

final class MockGetUsersUseCase: GetUsersUseCase {

    var users: [User] = []
    var error: Error?

    private(set) var executeCalled = false

    func execute() async throws -> [User] {

        executeCalled = true

        if let error {
            throw error
        }

        return users
    }
}
