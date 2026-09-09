//
//  UserRepositoryTests.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//

import XCTest
@testable import CleanArchitecture

final class UserRepositoryTests: XCTestCase {

    func test_getUsers_success() async throws {

        let apiClient = MockAPIClient()

        apiClient.result = [
            UserDTO(
                id: 1,
                name: "John",
                email: "john@example.com"
            ),
            UserDTO(
                id: 2,
                name: "Alice",
                email: "alice@example.com"
            )
        ]

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        let users = try await repository.getUsers()

        XCTAssertTrue(apiClient.getCalled)

        XCTAssertEqual(users.count, 2)

        XCTAssertEqual(users[0].id, 1)
        XCTAssertEqual(users[0].name, "John")
        XCTAssertEqual(users[0].email, "john@example.com")

        XCTAssertEqual(users[1].id, 2)
        XCTAssertEqual(users[1].name, "Alice")
        XCTAssertEqual(users[1].email, "alice@example.com")
    }

    func test_getUsers_mapsDTOToDomain() async throws {

        let apiClient = MockAPIClient()

        apiClient.result = [
            UserDTO(
                id: 10,
                name: "Test User",
                email: "test@example.com"
            )
        ]

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        let users = try await repository.getUsers()

        XCTAssertEqual(users.count, 1)

        let user = try XCTUnwrap(users.first)

        XCTAssertEqual(user.id, 10)
        XCTAssertEqual(user.name, "Test User")
        XCTAssertEqual(user.email, "test@example.com")
    }

    func test_getUsers_whenAPIClientFails_throwsError() async {

        let apiClient = MockAPIClient()
        apiClient.error = TestError.networkError

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        do {
            _ = try await repository.getUsers()

            XCTFail("Expected repository to throw an error")

        } catch {
            XCTAssertTrue(apiClient.getCalled)
            XCTAssertTrue(error is TestError)
        }
    }

    func test_getUsers_withEmptyResponse_returnsEmptyArray() async throws {

        let apiClient = MockAPIClient()

        apiClient.result = [UserDTO]()

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        let users = try await repository.getUsers()

        XCTAssertTrue(users.isEmpty)
    }
}
