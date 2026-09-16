//
//  UsersViewModelTests.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//


import XCTest
@testable import MVVMMockTimer

@MainActor
final class UsersViewModelTests: XCTestCase {

    func testLoadUsersSuccessUpdatesState() async {
        let service = MockUserService()
        service.result = .success([
            User(id: 1, name: "Alice", username: "alice", email: "alice@example.com")
        ])

        let viewModel = UsersViewModel(service: service)

        await viewModel.loadUsers()

        XCTAssertEqual(viewModel.users.count, 1)
        XCTAssertEqual(viewModel.users.first?.name, "Alice")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadUsersFailureUpdatesError() async {
        let service = MockUserService()
        service.result = .failure(MockError())

        let viewModel = UsersViewModel(service: service)

        await viewModel.loadUsers()

        XCTAssertTrue(viewModel.users.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

final class MockUserService: UserServicing{
    var result: Result<[User], Error> = .success([])

    func fetchUsers() async throws -> [User] {
        try result.get()
    }
}
