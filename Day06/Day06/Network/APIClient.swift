//
//  APIClient.swift
//  Day06
//
//  Created by HIMANK on 25/08/26.
//

import Foundation

import Foundation

final class APIClient: APIClientProtocol {

    private let session: URLSession
    private let baseURL: URL

    init(
        session: URLSession = .shared,
        baseURL: URL = URL(
            string: "https://jsonplaceholder.typicode.com"
        )!
    ) {
        self.session = session
        self.baseURL = baseURL
    }

    func request<T: Decodable>(
        endpoint: any Endpoint,
        responseType: T.Type
    ) async throws -> T {

        let url = try makeURL(from: endpoint)

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        endpoint.headers.forEach {
            request.setValue(
                $1,
                forHTTPHeaderField: $0
            )
        }

        do {
            let (data, response) = try await session.data(
                for: request
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

        var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false
        )

        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems

        guard let url = components?.url else {
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
