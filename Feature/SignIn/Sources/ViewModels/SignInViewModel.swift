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
    
    public init(signInTypes: [SignInType], useCase: SignInUseCase) {
        self.buttonViewModels = signInTypes.map { SignInButtonViewModel(from: $0) }
        self.useCase = useCase
    }
    
    // MARK: Properties
    
    let buttonViewModels: [SignInButtonViewModel]
    private(set) var showProgressView: Bool = false
    private let useCase: SignInUseCase
    
    // MARK: Methods
    
    func didTap(type: String) {
        Task { [weak self, useCase] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                let token = try await ThirdPartyAuthProvider.getToken(type: type)
                let result = try await useCase.signIn(type: type, token: token)
                #warning("앱 전체의 state 바꾸기")
            } catch {
                #warning("앱 전체의 state 바꾸기")
            }
        }
    }
}
