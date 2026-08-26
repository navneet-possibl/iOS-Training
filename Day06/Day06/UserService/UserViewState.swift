//
//  UserViewState.swift
//  Day06
//
//  Created by HIMANK on 26/08/26.
//


import Foundation

enum UserViewState {
    case idle
    case loading
    case loaded(User)
    case failed(String)
}