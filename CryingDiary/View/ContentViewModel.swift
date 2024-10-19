//
//  ContentViewModel.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation

protocol ContentViewModelType: Observable, Sendable {
    @MainActor var scene: ContentViewScene { get }
    
    func signInWithSavedToken()
}

@Observable
final class ContentViewModel {
    
    // MARK: Lifecycle
    
    init(authController: AuthControllable) {
        self.authController = authController
    }
    
    // MARK: Properties
    
    @MainActor private(set) var scene: ContentViewScene = .splash
    private let authController: AuthControllable
}

extension ContentViewModel: ContentViewModelType {
    func signInWithSavedToken() {
        Task { [authController] in
            if let user = await authController.trySignIn() {
                await MainActor.run { [weak self] in
                    self?.scene = .home(user)
                }
            } else {
                await MainActor.run { [weak self] in
                    self?.scene = .login
                }
            }
        }
    }
}
