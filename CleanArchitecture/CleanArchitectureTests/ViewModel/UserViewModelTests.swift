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
        let viewModel = UserViewModel(getUsers: useCase)

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_loadUsers_success() async {
        let useCase = MockGetUsersUseCase()
        useCase.users = [
            User(id: 1, name: "John", email: "john@example.com"),
            User(id: 2, name: "Alice", email: "alice@example.com")
        ]

        let viewModel = UserViewModel(getUsers: useCase)
        await viewModel.loadUsers()

        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.users[0].name, "John")
        XCTAssertEqual(viewModel.users[1].name, "Alice")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(useCase.executeCalled)
    }

    func test_loadUsers_failure() async {
        let useCase = MockGetUsersUseCase()
        useCase.error = TestError.networkError

        let viewModel = UserViewModel(getUsers: useCase)
        await viewModel.loadUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, TestError.networkError.localizedDescription)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(useCase.executeCalled)
    }

    func test_loadUsers_setsLoadingState() async {
        let useCase = MockGetUsersUseCase()
        useCase.isPaused = true
        useCase.users = [
            User(id: 1, name: "John", email: "john@example.com")
        ]

        let executeStarted = expectation(description: "execute started")
        useCase.onExecute = { executeStarted.fulfill() }

        let viewModel = UserViewModel(getUsers: useCase)
        let loadTask = Task {
            await viewModel.loadUsers()
        }

        await fulfillment(of: [executeStarted], timeout: 1)
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)

        useCase.resume()
        await loadTask.value

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.users.count, 1)
    }

    func test_loadUsers_emptyResponse() async {
        let useCase = MockGetUsersUseCase()
        useCase.users = []

        let viewModel = UserViewModel(getUsers: useCase)
        await viewModel.loadUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_loadUsers_preventsDuplicateLoadWhileLoading() async {
        let useCase = MockGetUsersUseCase()
        useCase.isPaused = true
        useCase.users = [
            User(id: 1, name: "John", email: "john@example.com")
        ]

        let executeStarted = expectation(description: "execute started")
        useCase.onExecute = { executeStarted.fulfill() }

        let viewModel = UserViewModel(getUsers: useCase)
        let firstLoad = Task {
            await viewModel.loadUsers()
        }

        await fulfillment(of: [executeStarted], timeout: 1)
        await viewModel.loadUsers()

        XCTAssertEqual(useCase.executeCallCount, 1)

        useCase.resume()
        await firstLoad.value

        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_loadUsers_canBeCalledAgainAfterCompletion() async {
        let useCase = MockGetUsersUseCase()
        useCase.users = [
            User(id: 1, name: "John", email: "john@example.com")
        ]

        let viewModel = UserViewModel(getUsers: useCase)

        await viewModel.loadUsers()
        await viewModel.loadUsers()

        XCTAssertEqual(useCase.executeCallCount, 2)
        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertFalse(viewModel.isLoading)
    }
}
