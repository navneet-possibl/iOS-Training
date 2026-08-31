//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import SwiftUI

@main
struct CleanArchitectureApp: App {
    
    private let container = AppDependencyContainer()

    var body: some Scene {
        WindowGroup {
            UserListView(
                viewModel: container.makeUserViewModel()
            )
        }
    }
}
