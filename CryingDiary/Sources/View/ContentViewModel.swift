//
//  ContentViewModel.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation
#warning("todo: Network 의존 제거 필요")
import Network

@MainActor
protocol ContentViewModelType: Observable {
    var showProgressView: Bool { get }
 
    func setAppStateUpdatable(_ appState: AppStateUpdatable)
    func signIn(with type: ThirdPartyLoginType)
    func signInWithSavedToken()
    func signOut()
    func unlink()
}

@Observable
@MainActor
final class ContentViewModel {
    
    // MARK: Lifecycle
    
    init(authController: AuthControllable, tokenStore: TokenStorable) {
        self.authController = authController
        self.tokenStore = tokenStore
    }
    
    // MARK: Properties

    private weak var appState: AppStateUpdatable?
    
    private(set) var showProgressView: Bool = false
    private let authController: AuthControllable
    private let tokenStore: TokenStorable
}

extension ContentViewModel: ContentViewModelType {
    func setAppStateUpdatable(_ appState: AppStateUpdatable) {
        self.appState = appState
    }
    
    func signIn(with type: ThirdPartyLoginType) {
        Task { [authController, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                let response = try await authController.signIn(with: type)
                self?.appState?.chageScene(to: .home(response.user))
                await self?.updateTokens(with: response)
            } catch {
                self?.appState?.appendToast(.init(message: "@@@ 에러가 발생했어요"))
            }
        }
    }
    
    func signInWithSavedToken() {
        Task { [authController, weak self] in
            if let response = await authController.trySignIn() {
                self?.appState?.chageScene(to: .home(response.user))
                await self?.updateTokens(with: response)
            } else {
                self?.appState?.chageScene(to: .login)
            }
        }
    }
    
    func signOut() {
        Task { [authController, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                try await authController.signOut()
                self?.appState?.chageScene(to: .login)
            } catch {
                self?.appState?.appendToast(.init(message: "@@@ 에러가 발생했어요"))
            }
        }
    }
    
    func unlink() {
        Task { [authController, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                try await authController.unlink()
                self?.appState?.chageScene(to: .login)
            } catch {
                self?.appState?.appendToast(.init(message: "@@@ 에러가 발생했어요"))
            }
        }
    }
}

private extension ContentViewModel {
    func updateTokens(with repsonse: SignInResponse) async {
        await tokenStore.updateTokens(accessToken: repsonse.accessToken, refreshToken: repsonse.user.refreshToken)
    }
}
