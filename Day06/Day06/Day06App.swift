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
            let container = AppDependencyContainer()
            let viewModel = container.makeUserViewModel()
            UserView(
                viewModel: viewModel
            )
        }
    }
}
