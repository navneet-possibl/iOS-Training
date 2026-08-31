//
//  UserDTO.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import Foundation

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String

    nonisolated func toDomain() -> User {
        User(
            id: id,
            name: name,
            email: email
        )
    }
}
