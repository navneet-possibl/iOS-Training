//
//  ApiPClient.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//

import Foundation

enum APIError: LocalizedError, Equatable {
    case invalidResponse
    case serverError(Int)
    case decodingError
    case networkError(String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid server response."
        case .serverError(let code):
            return "Server returned status code \(code)."
        case .decodingError:
            return "Unable to decode the response."
        case .networkError(let message):
            return message
        }
    }
}

protocol APIClient {
    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}



final class URLSessionAPIClient: APIClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw APIError.serverError(httpResponse.statusCode)
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error.localizedDescription)
        }
    }
}
