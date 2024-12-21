//
//  CryingDiaryApp.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI
import Domain

@main
struct CryingDiaryApp: App {
    
    // MARK: Properties
    
    @State private var toastWindow: UIWindow?
    private let dependency = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            RootView(
                viewModel: RootViewModel(useCase: dependency.signInUseCase),
                signInBuilder: dependency
            )
            .onOpenURL { url in
                handleURL(url)
            }
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
        @Bindable var bindableState = dependency.appState
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
