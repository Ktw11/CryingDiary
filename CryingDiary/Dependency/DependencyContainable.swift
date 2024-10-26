//
//  DependencyContainable.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/24/24.
//

import Foundation

protocol DependencyContainable {
    var tokenStore: TokenStorable { get }
    var loginInfoRepository: LoginInfoRepositoryType { get }
    var networkProvider: NetworkProvidable { get }
    var authController: AuthControllable { get }
}

extension DependencyContainable {
    @MainActor
    static var `default`: DependencyContainable {
        let tokenStore = TokenStore()
        return DependencyContainer(
            tokenStore: tokenStore,
            loginInfoRepository: LoginInfoRepository(),
            networkProvider: NetworkProvider(tokenStore: tokenStore)
        )
    }
}
