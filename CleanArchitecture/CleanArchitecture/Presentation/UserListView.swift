//
//  UserListView.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel: UserViewModel

    init(viewModel: UserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Users")
                .task {
                    await viewModel.loadUsers()
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.users.isEmpty {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.errorMessage {
            ContentUnavailableView(
                "Unable to Load Users",
                systemImage: "wifi.exclamationmark",
                description: Text(errorMessage)
            )
        } else {
            List(viewModel.users) { user in
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
