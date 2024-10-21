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
    }

    // MARK: Properties

    private let dependency: DependencyContainable = DependencyContainerKey.defaultValue
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(authController: dependency.authController))
                .environment(\.dependencyContainer, dependency)
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = KakaoSDKAuth.AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
