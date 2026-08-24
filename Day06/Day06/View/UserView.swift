//
//  ContentView.swift
//  Day06
//
//  Created by HIMANK on 24/08/26.
//

import SwiftUI

struct UserView: View {

    @StateObject private var viewModel = UserViewModel()

    //@StateObject vs @ObservedObject
    //StateObject -- Use it when the View creates and owns the ViewModel. -- The ViewModel instance is maintained across SwiftUI view updates.
    
    //ObservedObject -- Use it when the ViewModel is created elsewhere and injected into the View.
    
    var body: some View {
        VStack(spacing: 16) {

            if viewModel.isLoading {
                ProgressView()
            } else if let user = viewModel.user {
                Text(user.name)
                    .font(.title)
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

#Preview {
    UserView()
}
