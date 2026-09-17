//
//  MockURLSession.swift
//  CleanArchitecture
//
//  Created by HIMANK on 16/09/26.
//

import Foundation
@testable import CleanArchitecture

final class MockURLSession: URLSessionProtocol {

    var data: Data = Data()
    var response: URLResponse?
    var error: Error?

    private(set) var requestedURL: URL?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        requestedURL = url

        if let error {
            throw error
        }

        guard let response else {
            throw TestError.serverError
        }

        return (data, response)
    }
}
