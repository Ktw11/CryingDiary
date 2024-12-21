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

@MainActor final class DependencyContainer {
    
    // MARK: Properties
    
    let appState: GlobalAppState = .init()
    private let networkProvider: NetworkProvidable = NetworkProvider(configuration: NetworkConfiguration(baseURLString: AppKeys.baseURL))
    
    // Repositories
    private var authRepository: AuthRepository {
        AuthRepositoryImpl(networkProvider: networkProvider)
    }
    
    private var signInInfoRepository: SignInInfoRepository {
        SignInInfoRepositoryImpl()
    }
    
    // UseCases
    var signInUseCase: SignInUseCase {
        SignInUseCaseImpl(
            authRepository: authRepository,
            signInInfoRepository: signInInfoRepository
        )
    }
    
    // MARK: Methods
    
    func configure(tokenStore: TokenStorable) {
        Task {
            await networkProvider.setTokenStore(tokenStore)
        }
    }
}
