//
//  Day06App.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//

import SwiftUI

@main
struct Day06App: App {
    var body: some Scene {
        WindowGroup {

            let apiClient = APIClient()

            let userService = UserService(
                apiClient: apiClient
            )

            let userViewModel = UserViewModel(
                userService: userService
            )

            UserView(
                viewModel: userViewModel
            )
        }
    }
}
