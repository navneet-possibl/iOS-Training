//
//  UserServiceProtocol.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//
import Foundation

protocol UserServiceProtocol {
    func fetchUser(id : Int) async throws -> User
}

