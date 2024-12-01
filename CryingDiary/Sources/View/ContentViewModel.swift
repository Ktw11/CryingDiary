//
//  ContentViewModel.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation

@MainActor
protocol ContentViewModelType: Observable {
    var showProgressView: Bool { get }
 
    func setAppStateUpdatable(_ appState: AppStateUpdatable)
    func signIn(with type: SignInType)
    func signInWithSavedToken()
    func signOut()
    func unlink()
}

@Observable
@MainActor
final class ContentViewModel {
    
    // MARK: Lifecycle
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: Properties

    private weak var appState: AppStateUpdatable?
    
    private(set) var showProgressView: Bool = false
    private let authService: AuthServiceProtocol
}

extension ContentViewModel: ContentViewModelType {
    func setAppStateUpdatable(_ appState: AppStateUpdatable) {
        self.appState = appState
    }
    
    func signIn(with type: SignInType) {
        Task { [authService, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                let response = try await authService.signIn(with: type)
                self?.appState?.chageScene(to: .home(response.user))
            } catch {
                self?.appState?.appendToast(.init(message: "@@@ 에러가 발생했어요"))
            }
        }
    }
    
    func signInWithSavedToken() {
        Task { [authService, weak self] in
            if let response = await authService.trySignIn() {
                self?.appState?.chageScene(to: .home(response.user))
            } else {
                self?.appState?.chageScene(to: .login)
            }
        }
    }
    
    func signOut() {
        Task { [authService, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                try await authService.signOut()
                self?.appState?.chageScene(to: .login)
            } catch {
                self?.appState?.appendToast(.init(message: "@@@ 에러가 발생했어요"))
            }
        }
    }
    
    func unlink() {
        Task { [authService, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                try await authService.unlink()
                self?.appState?.chageScene(to: .login)
            } catch {
                self?.appState?.appendToast(.init(message: "@@@ 에러가 발생했어요"))
            }
        }
    }
}
