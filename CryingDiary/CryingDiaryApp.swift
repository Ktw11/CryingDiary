//
//  CryingDiaryApp.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct CryingDiaryApp: App {
    
    // MARK: Lifecycle
    
    init() {
        KakaoSDK.initSDK(appKey: AppKeys.kakaoAppKey)
        
        let tokenStore = TokenStore()
        let dependency = DependencyContainer(
            tokenStore: tokenStore,
            loginInfoRepository: LoginInfoRepository(),
            networkProvider: NetworkProvider(tokenStore: tokenStore)
        )
        self.dependency = dependency
    }
    
    // MARK: Properties
    
    @State private var toastWindow: UIWindow?
    private var appState: GlobalAppState = .init()
    private let dependency: DependencyContainable
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: dependency.makeContentViewModel())
            .onOpenURL { url in
                handleURL(url)
            }
            .environment(appState)
            .onAppear {
                setUpToastWindow()
            }
        }
    }
}

private extension CryingDiaryApp {
    func handleURL(_ url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            _ = KakaoSDKAuth.AuthController.handleOpenUrl(url: url)
            return
        }
    }
    
    func setUpToastWindow() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard toastWindow == nil else { return }
        
        let window = TouchPassThroughWindow(windowScene: scene)
        @Bindable var bindableState = appState
        let rootViewController = UIHostingController(rootView: ToastsView(toasts: $bindableState.toasts))
        rootViewController.view.frame = window.windowScene?.keyWindow?.frame ?? .zero
        rootViewController.view.backgroundColor = .clear
        
        window.rootViewController = rootViewController
        window.backgroundColor = .clear
        window.isUserInteractionEnabled = true
        window.isHidden = false
        toastWindow = window
    }
}
