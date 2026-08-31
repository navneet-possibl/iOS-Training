//
//  UserRepository.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//


protocol UserRepository {
    func getUsers() async throws -> [User]
}
