//
//  DependencyContainer.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import Foundation

protocol DependencyContainable: Sendable {
    var tokenStore: TokenStorable { get }
    var loginInfoRepository: LoginInfoRepositoryType { get }
    var networkProvider: NetworkProvidable { get }
    var authController: AuthControllable { get }
}

struct DependencyContainer: DependencyContainable {
    let tokenStore: TokenStorable
    let loginInfoRepository: LoginInfoRepositoryType
    let networkProvider: NetworkProvidable
    
    var authController: AuthControllable {
        AuthController(
            networkProvider: networkProvider,
            tokenStore: tokenStore,
            loginInfoRepository: loginInfoRepository,
            appleLoginHelper: AppleLoginHelper(),
            kakaoLoginHelper: KakaoLoginHelper()
        )
    }
}
