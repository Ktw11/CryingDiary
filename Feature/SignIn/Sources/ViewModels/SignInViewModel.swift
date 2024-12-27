//
//  SignInViewModel.swift
//  SignIn
//
//  Created by 공태웅 on 12/15/24.
//

import SwiftUI
import Domain
import ThirdParty

@Observable
@MainActor
public final class SignInViewModel {
    
    // MARK: Lifecycle

    public init(
        dependency: SignInDependency,
        didSignIn: @escaping ((SignInResponse) -> Void)
    ){
        self.buttonViewModels = dependency.signInTypes
            .map { SignInButtonViewModel(from: $0) }
        self.useCase = dependency.useCase
        self.appState = dependency.appState
        self.didSignIn = didSignIn
    }
    
    // MARK: Properties
    
    let buttonViewModels: [SignInButtonViewModel]
    private(set) var showProgressView: Bool = false
    
    private let useCase: SignInUseCase
    private let didSignIn: ((SignInResponse) -> Void)
    private let appState: AppStateUpdatable
    
    // MARK: Methods
    
    func didTap(type: String) {
        Task { [weak self, useCase] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                let token = try await ThirdPartyAuthProvider.getToken(type: type)
                let response = try await useCase.signIn(type: type, token: token)
                self?.didSignIn(response)
            } catch {
                self?.appState.appendToast(Toast(message: String(localized: "에러가 발생했습니다. 잠시 후 시도해주세요.")))
            }
        }
    }
}
