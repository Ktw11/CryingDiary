//
//  CryingDiaryApp.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI

@main
struct CryingDiaryApp: App {
    
    // MARK: Properties
    
    @State private var toastWindow: UIWindow?
    private var appState: GlobalAppState = .init()
    private let dependency: DependencyContainer = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            dependency.signInView()
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
//        dependency.handleURL(url)
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
