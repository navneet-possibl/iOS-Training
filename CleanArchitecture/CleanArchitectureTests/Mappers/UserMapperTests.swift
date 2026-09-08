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
}
