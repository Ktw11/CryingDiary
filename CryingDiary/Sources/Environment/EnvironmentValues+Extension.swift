//
//  EnvironmentValues+Extension.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/10/24.
//

import SwiftUI
import Network

extension EnvironmentValues {
    @Entry var dependencyContainer: DependencyContainable = {
        let tokenStore = TokenStore()
        return DependencyContainer(
            tokenStore: tokenStore,
            loginInfoRepository: LoginInfoRepository(),
            networkProvider: NetworkProvider(
                configuration: NetworkConfiguration(baseURLString: AppKeys.baseURL),
                tokenStore: tokenStore
            )
        )
    }()
}
