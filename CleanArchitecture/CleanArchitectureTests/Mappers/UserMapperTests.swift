//
//  UserMapperTests.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//

import XCTest
@testable import CleanArchitecture

final class UserMapperTests: XCTestCase {

    func test_userDTO_mapsToDomainUser() {
        let dto = UserDTO(
            id: 1,
            name: "John",
            email: "john@example.com"
        )

        let user = dto.toDomain()

        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "John")
        XCTAssertEqual(user.email, "john@example.com")
    }

    func test_userDTOs_mapToDomainUsers() {
        let dtos = [
            UserDTO(id: 1, name: "John", email: "john@example.com"),
            UserDTO(id: 2, name: "Alice", email: "alice@example.com")
        ]

        let users = dtos.map { $0.toDomain() }

        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0], User(id: 1, name: "John", email: "john@example.com"))
        XCTAssertEqual(users[1], User(id: 2, name: "Alice", email: "alice@example.com"))
    }
}
