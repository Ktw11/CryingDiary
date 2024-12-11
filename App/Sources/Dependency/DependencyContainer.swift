//
//  DependencyContainer.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import Foundation
//import SwiftUI
//import Network
//import ThirdPartyAuth
//import Service
//import Repository

//@MainActor final class DependencyContainer {
//
//    // MARK: Lifecycle
//    
//    init() {
//        let tokenStore = TokenStore()
//        self.networkProvider = NetworkProvider(
//            configuration: NetworkConfiguration(baseURLString: AppKeys.baseURL)
//        )
//        self.tokenStore = tokenStore
//        self.signInInfoRepository = SignInInfoRepository()
//        
//        configureDependencies()
//    }
//    
//    // MARK: Properties
//    
//    private let tokenStore: TokenStore
//    private let networkProvider: NetworkProvidable
//    private let signInInfoRepository: SignInInfoRepositoryType
//}
//
//private extension DependencyContainer {
//    func configureDependencies() {
//        ThirdPartyAuthProvider.configure()
//        
//        Task {
//            await networkProvider.setTokenStore(tokenStore)
//        }
//    }
//}
//
//extension DependencyContainer: DependencyContainable {
//    func handleURL(_ url: URL) {
//        ThirdPartyAuthProvider.handleURL(url)
//    }
//
//    func makeContentViewModel() -> ContentViewModelType {
//        ContentViewModel(
//            authService: AuthService(
//                networkProvider: networkProvider,
//                signInInfoRepository: signInInfoRepository,
//                tokenStore: tokenStore
//            )
//        )
//    }
//}
