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
        apiClient.stub = .users([
            UserDTO(id: 1, name: "John", email: "john@example.com"),
            UserDTO(id: 2, name: "Alice", email: "alice@example.com")
        ])

        let repository = UserRepositoryImpl(apiClient: apiClient)
        let users = try await repository.getUsers()

        XCTAssertTrue(apiClient.getCalled)
        XCTAssertEqual(
            apiClient.requestedURL,
            URL(string: UserRepositoryImpl.defaultUsersEndpoint)
        )
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0], User(id: 1, name: "John", email: "john@example.com"))
        XCTAssertEqual(users[1], User(id: 2, name: "Alice", email: "alice@example.com"))
    }

    func test_getUsers_mapsDTOToDomain() async throws {
        let apiClient = MockAPIClient()
        apiClient.stub = .users([
            UserDTO(id: 10, name: "Test User", email: "test@example.com")
        ])

        let repository = UserRepositoryImpl(apiClient: apiClient)
        let users = try await repository.getUsers()
        let user = try XCTUnwrap(users.first)

        XCTAssertEqual(user, User(id: 10, name: "Test User", email: "test@example.com"))
    }

    func test_getUsers_whenAPIClientFails_throwsNetworkError() async {
        let apiClient = MockAPIClient()
        apiClient.stub = .failure(TestError.networkError)

        let repository = UserRepositoryImpl(apiClient: apiClient)

        do {
            _ = try await repository.getUsers()
            XCTFail("Expected repository to throw TestError.networkError")
        } catch let error as TestError {
            XCTAssertTrue(apiClient.getCalled)
            XCTAssertEqual(error, .networkError)
        } catch {
            XCTFail("Expected TestError.networkError, got \(error)")
        }
    }

    func test_getUsers_withEmptyResponse_returnsEmptyArray() async throws {
        let apiClient = MockAPIClient()
        apiClient.stub = .users([])

        let repository = UserRepositoryImpl(apiClient: apiClient)
        let users = try await repository.getUsers()

        XCTAssertTrue(users.isEmpty)
    }

    func test_getUsers_withEmptyEndpoint_throwsInvalidURL() async {
        let apiClient = MockAPIClient()
        let repository = UserRepositoryImpl(
            apiClient: apiClient,
            usersEndpoint: ""
        )

        do {
            _ = try await repository.getUsers()
            XCTFail("Expected repository to throw APIError.invalidURL")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidURL)
            XCTAssertFalse(apiClient.getCalled)
        } catch {
            XCTFail("Expected APIError.invalidURL, got \(error)")
        }
    }

    func test_getUsers_withWhitespaceEndpoint_throwsInvalidURL() async {
        let apiClient = MockAPIClient()
        let repository = UserRepositoryImpl(
            apiClient: apiClient,
            usersEndpoint: "   "
        )

        do {
            _ = try await repository.getUsers()
            XCTFail("Expected repository to throw APIError.invalidURL")
        } catch let error as APIError {
            XCTAssertEqual(error, .invalidURL)
            XCTAssertFalse(apiClient.getCalled)
        } catch {
            XCTFail("Expected APIError.invalidURL, got \(error)")
        }
    }
}
