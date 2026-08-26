//
//  APIClient.swift
//  Day06
//
//  Created by HIMANK on 25/08/26.
//

import Foundation

final class APIClient: APIClientProtocol {

    func request<T: Decodable>(
        endpoint: any Endpoint,
        responseType: T.Type
    ) async throws -> T {

        let url = try makeURL(from: endpoint)

        do {
            let (data, response) = try await URLSession.shared.data(
                from: url
            )

            try validate(response)

            return try decode(
                responseType,
                from: data
            )

        } catch let error as APIError {
            throw error

        } catch {
            throw APIError.networkError(error)
        }
    }

    // MARK: - URL

    private func makeURL(
        from endpoint: any Endpoint
    ) throws -> URL {

        guard let url = URL(string: endpoint.urlString) else {
            throw APIError.invalidURL
        }

        return url
    }

    // MARK: - Response Validation

    private func validate(
        _ response: URLResponse
    ) throws {

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw APIError.invalidStatusCode(
                httpResponse.statusCode
            )
        }
    }

    // MARK: - Decoding

    private func decode<T: Decodable>(
        _ type: T.Type,
        from data: Data
    ) throws -> T {

        do {
            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
