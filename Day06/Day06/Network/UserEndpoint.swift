//
//  UserEndpoint.swift
//  Day06
//
//  Created by HIMANK on 26/08/26.
//


import Foundation

protocol Endpoint {
    var urlString: String { get }
}

enum UserEndpoint: Endpoint {
    case user(id: Int)

    var urlString: String {
        switch self {
        case .user(let id):
            return "https://jsonplaceholder.typicode.com/users/\(id)"
        }
    }
}
