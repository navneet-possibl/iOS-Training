//
//  MockAPIClient.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//


import Foundation
@testable import CleanArchitecture


final class MockAPIClient: APIClientProtocol {

    var result: Any?
    var error: Error?

    private(set) var getCalled = false
    private(set) var requestedURL: URL?

    func get<T: Decodable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T {

        getCalled = true
        requestedURL = url

        if let error = error {
            throw error
        }

        guard let result = result as? T else {
            throw TestError.serverError
        }

        return result
    }
}
