//
//  AppDependencyContainer.swift
//  CleanArchitecture
//
//  Created by HIMANK on 31/08/26.
//
import Foundation

final class AppDependencyContainer {
    private lazy var apiClient: APIClientProtocol = APIClient(
        session: .shared
    )

    private lazy var userRepository: UserRepository = UserRepositoryImpl(
        apiClient: apiClient
    )

    private lazy var getUsersUseCase: GetUsersUseCase = GetUsersUseCaseImpl(
        repository: userRepository
    )

    func makeUserViewModel() -> UserViewModel {
        UserViewModel(getUsers: getUsersUseCase)
    }
}
