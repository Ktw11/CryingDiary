//
//  SignInViewModel.swift
//  SignIn
//
//  Created by 공태웅 on 12/15/24.
//

import SwiftUI
import UseCase

@Observable
@MainActor
public final class SignInViewModel {
    
    // MARK: Lifecycle
    
    init(signInTypes: [SignInType], useCase: SignInUseCase) {
        self.buttonViewModels = signInTypes.map { SignInButtonViewModel(from: $0) }
        self.useCase = useCase
    }
    
    // MARK: Properties
    
    let buttonViewModels: [SignInButtonViewModel]
    private(set) var showProgressView: Bool = false
    private let useCase: SignInUseCase
    
    // MARK: Methods
    
    func didTap(id: String) {
        guard let type = SignInType(rawValue: id) else { return }
                
        Task { [weak self, useCase] in
            self?.showProgressView = true
            defer { self?.showProgressView = false }
            
            do {
                try await useCase.signIn(with: type)
                // 앱 전체의 state 바꾸기
            } catch {
                // 앱 전체의 state 바꾸기
            }
        }
    }
}
