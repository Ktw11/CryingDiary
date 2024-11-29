//
//  DependencyContainer.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import Foundation
import SwiftUI
import Network

struct DependencyContainer {
    
    // MARK: Lifecycle
    
    init(
        tokenStore: TokenStorable,
        loginInfoRepository: LoginInfoRepositoryType,
        networkProvider: NetworkProvidable
    ) {
        self.tokenStore = tokenStore
        self.loginInfoRepository = loginInfoRepository
        self.networkProvider = networkProvider
        self.authController = AuthController(
            networkProvider: networkProvider,
            loginInfoRepository: loginInfoRepository,
            loginHelperFactory: LoginHelperFactory()
        )
    }
    
    // MARK: Properties
    
    private let tokenStore: TokenStorable
    private let loginInfoRepository: LoginInfoRepositoryType
    private let networkProvider: NetworkProvidable
    private let authController: AuthControllable
}

extension DependencyContainer: DependencyContainable {
    @MainActor
    func makeContentViewModel() -> ContentViewModelType {
        ContentViewModel(
            authController: authController,
            tokenStore: tokenStore
        )
    }
}
