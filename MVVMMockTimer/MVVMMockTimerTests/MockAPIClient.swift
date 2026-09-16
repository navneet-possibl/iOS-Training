//
//  MVVMMockTimerTests.swift
//  MVVMMockTimerTests
//
//  Created by HIMANK on 16/09/26.
//


import Foundation
@testable import MVVMMockTimer

final class MockAPIClient: APIClient {
    var result: Result<Any, Error> = .success([])

    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        switch result {
        case .success(let value):
            guard let value = value as? T else {
                throw APIError.decodingError
            }
            return value
        case .failure(let error):
            throw error
        }
    }
}

struct MockError: Error, Equatable {}
