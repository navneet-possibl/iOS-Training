//
//  UserViewModelTests.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//


import XCTest
@testable import CleanArchitecture

@MainActor
final class UserViewModelTests: XCTestCase {
    
    
    func test_initialState() {

            let useCase = MockGetUsersUseCase()

            let viewModel = UserViewModel(
                getUsers: useCase
            )

            XCTAssertTrue(viewModel.users.isEmpty)
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertNil(viewModel.errorMessage)
        }

    func test_loadUsers_success() async {

        let useCase = MockGetUsersUseCase()

        useCase.users = [
            User(
                id: 1,
                name: "John",
                email: "john@example.com"
            ),
            User(
                id: 2,
                name: "Alice",
                email: "alice@example.com"
            )
        ]

        let viewModel = UserViewModel(
            getUsers: useCase
        )

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)

        await viewModel.loadUsers()

        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.users[0].name, "John")
        XCTAssertEqual(viewModel.users[1].name, "Alice")

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)

        XCTAssertTrue(useCase.executeCalled)
    }

    
    func test_getUsers_emptyResponse_returnsEmptyArray() async throws {

        let apiClient = MockAPIClient()

        apiClient.result = [UserDTO]()

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        let users = try await repository.getUsers()

        XCTAssertTrue(users.isEmpty)
    }
    
    func test_getUsers_singleUser() async throws {

        let apiClient = MockAPIClient()

        apiClient.result = [
            UserDTO(
                id: 1,
                name: "John",
                email: "john@example.com"
            )
        ]

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        let users = try await repository.getUsers()

        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.name, "John")
    }
    
    func test_getUsers_manyUsers() async throws {

        let apiClient = MockAPIClient()

        apiClient.result = (1...100).map {
            UserDTO(
                id: $0,
                name: "User \($0)",
                email: "user\($0)@example.com"
            )
        }

        let repository = UserRepositoryImpl(
            apiClient: apiClient
        )

        let users = try await repository.getUsers()

        XCTAssertEqual(users.count, 100)
    }
    
    func test_execute_usersWithSameName() async throws {

        let repository = MockUserRepository()

        repository.users = [
            User(
                id: 1,
                name: "John",
                email: "john1@example.com"
            ),
            User(
                id: 2,
                name: "John",
                email: "john2@example.com"
            )
        ]

        let useCase = GetUsersUseCaseImpl(
            repository: repository
        )

        let users = try await useCase.execute()

        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].name, "John")
        XCTAssertEqual(users[1].name, "John")
    }
    
    func test_loadUsers_failure_setsErrorMessage() async {

        let useCase = MockGetUsersUseCase()

        useCase.error = TestError.networkError

        let viewModel = UserViewModel(
            getUsers: useCase
        )

        await viewModel.loadUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)

        XCTAssertTrue(useCase.executeCalled)
    }

    func test_loadUsers_emptyResponse() async {

        let useCase = MockGetUsersUseCase()
        useCase.users = []

        let viewModel = UserViewModel(
            getUsers: useCase
        )

        await viewModel.loadUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_loadUsers_canBeCalledMultipleTimes() async {

        let useCase = MockGetUsersUseCase()

        useCase.users = [
            User(
                id: 1,
                name: "John",
                email: "john@example.com"
            )
        ]

        let viewModel = UserViewModel(
            getUsers: useCase
        )

        await viewModel.loadUsers()

        XCTAssertEqual(viewModel.users.count, 1)

        await viewModel.loadUsers()

        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertFalse(viewModel.isLoading)
    }
}
