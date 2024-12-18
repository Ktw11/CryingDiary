//
//  DependencyContainer.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import SwiftUI
import Repository
import Network
import Domain
import SignIn

@MainActor final class DependencyContainer {
    
    // MARK: Properties
    
    private let networkProvider: NetworkProvidable = NetworkProvider(configuration: NetworkConfiguration(baseURLString: AppKeys.baseURL))
    
    private var authRepository: AuthRepository {
        AuthRepositoryImpl(networkProvider: networkProvider)
    }
    
    // MARK: Methods
    
    func configure(tokenStore: TokenStorable) {
        Task {
            await networkProvider.setTokenStore(tokenStore)
        }
    }

    @ViewBuilder
    func signInView() -> some View {
        let viewModel = SignInViewModel(
            signInTypes: [.apple, .kakao],
            useCase: SignInUseCaseImpl(repository: authRepository)
        )
        SignInView(viewModel: viewModel)
    }
}
