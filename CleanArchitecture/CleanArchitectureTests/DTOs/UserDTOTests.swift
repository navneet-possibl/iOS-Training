//
//  UserDTOTests.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//


import XCTest
@testable import CleanArchitecture

final class UserDTOTests: XCTestCase {

    func test_toDomain_mapsCorrectly() {

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