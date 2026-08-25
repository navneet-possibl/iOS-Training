//
//  APIClientProtocol.swift
//  Day06
//
//  Created by HIMANK on 25/08/26.
//


import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(
        from urlString: String,
        responseType: T.Type
    ) async throws -> T
}