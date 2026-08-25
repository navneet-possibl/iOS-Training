//
//  ContentView.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//

import SwiftUI

struct UserView: View {

    //@StateObject vs @ObservedObject
    //StateObject -- Use it when the View creates and owns the ViewModel. -- The ViewModel instance is maintained across SwiftUI view updates.
    
    //ObservedObject -- Use it when the ViewModel is created elsewhere and injected into the View.
    
    @StateObject private var viewModel: UserViewModel

    init(viewModel: UserViewModel) {
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }

    var body: some View {
        VStack(spacing: 16) {

            if viewModel.isLoading {
                ProgressView()

            } else if let user = viewModel.user {
                VStack(spacing: 8) {
                    Text(user.name)
                        .font(.title)

                    Text(user.email)
                        .foregroundStyle(.secondary)
                }

            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }

            Button("Load User") {
                Task {
                    await viewModel.fetchUser()
                }
            }
        }
        .padding()
    }
}
