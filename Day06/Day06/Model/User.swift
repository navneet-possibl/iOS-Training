//
//  User.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//
import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
