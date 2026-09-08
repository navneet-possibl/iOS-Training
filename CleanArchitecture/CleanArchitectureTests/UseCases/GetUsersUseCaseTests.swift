//
//  GetUsersUseCaseTests.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//


import XCTest
@testable import CleanArchitecture

final class GetUsersUseCaseTests: XCTestCase {

    func test_execute_returnsUsersSortedByName() async throws {

        let repository = MockUserRepository()

        repository.users = [
            User(
                id: 1,
                name: "Zack",
                email: "zack@example.com"
            ),
            User(
                id: 2,
                name: "Alice",
                email: "alice@example.com"
            ),
            User(
                id: 3,
                name: "John",
                email: "john@example.com"
            )
        ]

        let useCase = GetUsersUseCaseImpl(
            repository: repository
        )

        let users = try await useCase.execute()

        XCTAssertEqual(users.count, 3)
        XCTAssertEqual(users[0].name, "Alice")
        XCTAssertEqual(users[1].name, "John")
        XCTAssertEqual(users[2].name, "Zack")

        XCTAssertTrue(repository.getUsersCalled)
    }

    func test_execute_whenRepositoryFails_throwsError() async {

        let repository = MockUserRepository()
        repository.error = TestError.networkError

        let useCase = GetUsersUseCaseImpl(
            repository: repository
        )

        do {
            _ = try await useCase.execute()

            XCTFail("Expected execute() to throw an error")

        } catch {
            XCTAssertTrue(repository.getUsersCalled)
            XCTAssertTrue(error is TestError)
        }
    }

    func test_execute_withEmptyRepository_returnsEmptyArray() async throws {

        let repository = MockUserRepository()
        repository.users = []

        let useCase = GetUsersUseCaseImpl(
            repository: repository
        )

        let users = try await useCase.execute()

        XCTAssertTrue(users.isEmpty)
        XCTAssertTrue(repository.getUsersCalled)
    }
}
