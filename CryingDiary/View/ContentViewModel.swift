//
//  ContentViewModel.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation

@MainActor
protocol ContentViewModelType: Observable {
    var scene: ContentViewScene { get }
    var showProgressView: Bool { get }
 
    func signIn(with type: ThirdPartyLoginType)
    func signInWithSavedToken()
    func signOut()
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
    
    private(set) var scene: ContentViewScene = .splash
    private(set) var showProgressView: Bool = false
    private let authController: AuthControllable
    private let tokenStore: TokenStorable
}

extension ContentViewModel: ContentViewModelType {
    func signIn(with type: ThirdPartyLoginType) {
        Task { [authController, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                let response = try await authController.signIn(with: type)
                self?.scene = .home(response.user)
                await self?.updateTokens(with: response)
            } catch {
                #warning("Toast or Alert 추가")
            }
        }
    }
    
    func signInWithSavedToken() {
        Task { [authController, weak self] in
            if let response = await authController.trySignIn() {
                self?.scene = .home(response.user)
                await self?.updateTokens(with: response)
            } else {
                self?.scene = .login
            }
        }
    }
    
    func signOut() {
        Task { [authController, weak self] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                try await authController.signOut()
                self?.scene = .login
            } catch {
                #warning("Toast or Alert 추가")
            }
        }
    }
}

private extension ContentViewModel {
    func updateTokens(with repsonse: SignInResponse) async {
        await tokenStore.updateTokens(accessToken: repsonse.accessToken, refreshToken: repsonse.user.refreshToken)
    }
}
