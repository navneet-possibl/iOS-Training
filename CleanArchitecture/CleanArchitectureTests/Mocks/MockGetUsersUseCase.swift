//
//  MockGetUsersUseCase.swift
//  CleanArchitecture
//
//  Created by HIMANK on 08/09/26.
//

import Foundation
@testable import CleanArchitecture

final class MockGetUsersUseCase: GetUsersUseCase {

    var users: [User] = []
    var error: Error?

    var isPaused = false
    var onExecute: (() -> Void)?

    private(set) var executeCallCount = 0
    private var resumeContinuation: CheckedContinuation<Void, Never>?

    var executeCalled: Bool { executeCallCount > 0 }

    func execute() async throws -> [User] {
        executeCallCount += 1
        onExecute?()

        if isPaused {
            await withCheckedContinuation { continuation in
                resumeContinuation = continuation
            }
        }

        if let error {
            throw error
        }

        return users
    }

    func resume() {
        resumeContinuation?.resume()
        resumeContinuation = nil
        isPaused = false
    }
}
