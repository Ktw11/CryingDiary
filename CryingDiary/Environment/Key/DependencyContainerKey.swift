//
//  DependencyContainerKey.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import SwiftUI

struct DependencyContainerKey: EnvironmentKey {
    static let defaultValue: DependencyContainable = {
        let tokenStore = TokenStore()
        
        return DependencyContainer(
            tokenStore: tokenStore,
            loginInfoRepository: LoginInfoRepository(),
            networkProvider: NetworkProvider(tokenStore: tokenStore)
        )
    }()
}
