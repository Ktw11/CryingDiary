//
//  CryingDiaryApp.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct CryingDiaryApp: App {
    
    // MARK: Lifecycle
    
    init() {
        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: AppKeys.kakaoAppKey)
        
        let dependency = DependencyContainer.default
        self.tokenStore = dependency.tokenStore
        self.networkProvider = dependency.networkProvider
        self.authController = dependency.authController
    }

    // MARK: Properties

    private let tokenStore: TokenStorable
    private let networkProvider: NetworkProvidable
    private let authController: AuthControllable
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(authController: authController, tokenStore: tokenStore))
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = KakaoSDKAuth.AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
