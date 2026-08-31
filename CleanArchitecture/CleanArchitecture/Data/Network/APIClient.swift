//
//  APIClient.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//
import Foundation

protocol APIClientProtocol {
    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}

enum APIError: LocalizedError {
    case invalidResponse
    case httpStatus(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpStatus(let status):
            return "The server returned HTTP status \(status)."
        }
    }
}

final class APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpStatus(httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
