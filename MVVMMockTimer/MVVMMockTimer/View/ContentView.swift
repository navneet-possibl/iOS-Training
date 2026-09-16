//
//  ContentView.swift
//  MVVMMockTimer
//
//  Created by HIMANK on 16/09/26.
//

import SwiftUI

struct UsersView: View {
    @State private var viewModel: UsersViewModel

    init(viewModel: UsersViewModel) {
           _viewModel = State(initialValue: viewModel)
       }


    var body: some View {
        
        VStack{
            if viewModel.isLoading {
                ProgressView("Loading users…")
            } else if let error = viewModel.errorMessage {
                Text(error)
            } else if viewModel.users.isEmpty {
                Text("No Users")
            } else {
                List(viewModel.users) { user in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.name)
                        Text("@\(user.username)")
                        Text(user.email)
                    }
                   
                }
            }
        }
        
        .task {
            await viewModel.loadUsers()
        }
    }

   
}


#Preview {
    UsersView(
        viewModel: UsersViewModel(
            service: UserService(
                apiClient: URLSessionAPIClient()
            )
        )
    )
}
