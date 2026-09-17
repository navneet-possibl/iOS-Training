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
            User(id: 1, name: "Zack", email: "zack@example.com"),
            User(id: 2, name: "Alice", email: "alice@example.com"),
            User(id: 3, name: "John", email: "john@example.com")
        ]

        let useCase = GetUsersUseCaseImpl(repository: repository)
        let users = try await useCase.execute()

        XCTAssertEqual(users.map(\.name), ["Alice", "John", "Zack"])
        XCTAssertTrue(repository.getUsersCalled)
    }

    func test_execute_whenRepositoryFails_throwsNetworkError() async {
        let repository = MockUserRepository()
        repository.error = TestError.networkError

        let useCase = GetUsersUseCaseImpl(repository: repository)

        do {
            _ = try await useCase.execute()
            XCTFail("Expected execute() to throw TestError.networkError")
        } catch let error as TestError {
            XCTAssertTrue(repository.getUsersCalled)
            XCTAssertEqual(error, .networkError)
        } catch {
            XCTFail("Expected TestError.networkError, got \(error)")
        }
    }

    func test_execute_withEmptyRepository_returnsEmptyArray() async throws {
        let repository = MockUserRepository()
        repository.users = []

        let useCase = GetUsersUseCaseImpl(repository: repository)
        let users = try await useCase.execute()

        XCTAssertTrue(users.isEmpty)
        XCTAssertTrue(repository.getUsersCalled)
    }

    func test_execute_usersWithSameName_keepsBothUsers() async throws {
        let repository = MockUserRepository()
        repository.users = [
            User(id: 1, name: "John", email: "john1@example.com"),
            User(id: 2, name: "John", email: "john2@example.com")
        ]

        let useCase = GetUsersUseCaseImpl(repository: repository)
        let users = try await useCase.execute()

        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].name, "John")
        XCTAssertEqual(users[1].name, "John")
    }
}
