//
//  MVVMMockTimerApp.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//

import SwiftUI

@main
struct MVVMMockTimerApp: App {
    var body: some Scene {
        WindowGroup {
            UsersView(
                viewModel: UsersViewModel(
                    service: UserService(
                        apiClient: URLSessionAPIClient()
                    )
                )
            )

        }
    }
}
