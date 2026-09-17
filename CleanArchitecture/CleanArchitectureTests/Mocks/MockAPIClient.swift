//
//  MockAPIClient.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//

import Foundation
@testable import CleanArchitecture

final class MockAPIClient: APIClientProtocol {

    enum Stub {
        case users([UserDTO])
        case failure(Error)
    }

    var stub: Stub = .users([])

    private(set) var getCallCount = 0
    private(set) var requestedURL: URL?

    var getCalled: Bool { getCallCount > 0 }

    func get<T: Decodable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T {

        getCallCount += 1
        requestedURL = url

        switch stub {
        case .failure(let error):
            throw error

        case .users(let users):
            switch type {
            case is [UserDTO].Type:
                guard let mapped = users as? T else {
                    throw TestError.invalidResponse
                }
                return mapped

            default:
                throw TestError.invalidResponse
            }
        }
    }
}
