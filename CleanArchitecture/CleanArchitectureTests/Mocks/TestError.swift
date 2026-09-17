//
//  TestError.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//

import Foundation

enum TestError: Error, Equatable, LocalizedError {
    case networkError
    case serverError
    case invalidResponse
    case invalidURL
    case decodingError

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "A network error occurred."
        case .serverError:
            return "A server error occurred."
        case .invalidResponse:
            return "The response was invalid."
        case .invalidURL:
            return "The URL was invalid."
        case .decodingError:
            return "Decoding failed."
        }
    }
}
