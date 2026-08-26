//
//  AppDependencyContainer.swift
//  Day06
//
//  Created by HIMANK on 26/08/26.
//


import Foundation

final class AppDependencyContainer {

    private let apiClient: any APIClientProtocol

    init(
        apiClient: any APIClientProtocol = APIClient()
    ) {
        self.apiClient = apiClient
    }

    func makeUserViewModel() -> UserViewModel {

        let userService = UserService(
            apiClient: apiClient
        )

        return UserViewModel(
            userService: userService
        )
    }
}


/*UserView
 │
 │ User Action
 ▼
UserViewModel
 │
 │ UserServiceProtocol
 ▼
UserService
 │
 │ APIClientProtocol
 ▼
APIClient
 │
 │ Endpoint
 ▼
UserEndpoint
 │
 ▼
URLSession*/
