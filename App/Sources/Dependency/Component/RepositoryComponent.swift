//
//  RepositoryComponent.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/27/24.
//

import Foundation
import Feature
import Domain
import Repository
import Network

final class RepositoryComponent: RepositoryBuilder {
    
    init(networkProvider: NetworkProvidable) {
        self.networkProvider = networkProvider
    }
    
    private let networkProvider: NetworkProvidable
    
    var authRepository: AuthRepository {
        AuthRepositoryImpl(networkProvider: networkProvider)
    }
    
    var signInInfoRepository: SignInInfoRepository {
        SignInInfoRepositoryImpl()
    }
}
