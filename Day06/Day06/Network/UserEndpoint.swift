//
//  UserEndpoint.swift
//  Day06
//
//  Created by HIMANK on 26/08/26.
//


import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum UserEndpoint: Endpoint {
    case user(id: Int)

    var path: String {
        switch self {
        case .user(let id):
            return "/users/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] {
        [:]
    }

    var queryItems: [URLQueryItem] {
        []
    }
}
