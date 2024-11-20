//
//  DependencyContainer+Previews.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/10/24.
//

import Foundation

extension DependencyContainer {
    @MainActor
    static var previewDefault: Self {
        let tokenStore = TokenStore()
        return DependencyContainer(
            tokenStore: tokenStore,
            loginInfoRepository: LoginInfoRepository(),
            networkProvider: NetworkProvider(tokenStore: tokenStore)
        )
    }
}
