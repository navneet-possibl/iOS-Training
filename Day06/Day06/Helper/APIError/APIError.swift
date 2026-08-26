//
//  APIError.swift
//  Day06
//
//  Created by HIMANK on 25/08/26.
//


import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case networkError(Error)
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."

        case .invalidResponse:
            return "Invalid server response."

        case .invalidStatusCode(let statusCode):
            return "Server returned status code: \(statusCode)."

        case .networkError:
            return "A network error occurred."

        case .decodingError:
            return "Unable to decode the server response."
        }
    }
}
