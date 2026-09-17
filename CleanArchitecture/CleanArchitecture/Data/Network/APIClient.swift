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

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

enum APIError: LocalizedError, Equatable {

    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decodingError

    var errorDescription: String? {
        switch self {

        case .invalidURL:
            return "The URL is invalid."

        case .invalidResponse:
            return "The server returned an invalid response."

        case .httpStatus(let status):
            return "The server returned HTTP status \(status)."

        case .decodingError:
            return "The server returned data in an unexpected format."
        }
    }
}

final class APIClient: APIClientProtocol {

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
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

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
