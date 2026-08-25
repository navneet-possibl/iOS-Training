//
//  APIClient.swift
//  Day06
//
//  Created by HIMANK on 25/08/26.
//


import Foundation

final class APIClient: APIClientProtocol {

    func request<T: Decodable>(
        from urlString: String,
        responseType: T.Type
    ) async throws -> T {

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(
            from: url
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw APIError.invalidStatusCode(
                httpResponse.statusCode
            )
        }

        do {
            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch {
            throw APIError.decodingError
        }
    }
}