//
//  User.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
