//
//  DependencyContainer.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import Foundation

struct DependencyContainer: DependencyContainable {
    let tokenStore: TokenStorable
    let loginInfoRepository: LoginInfoRepositoryType
    let networkProvider: NetworkProvidable
    
    var authController: AuthControllable {
        AuthController(
            networkProvider: networkProvider,
            loginInfoRepository: loginInfoRepository,
            loginHelperFactory: LoginHelperFactory()
        )
    }
}
