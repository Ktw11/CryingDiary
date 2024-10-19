//
//  LoginViewModel.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import Foundation

protocol LoginViewModelType: Observable, Sendable {
    @MainActor var showProgressView: Bool { get }

    func signIn(with type: ThirdPartyLoginType) async throws
}

@Observable
final class LoginViewModel {
    
    // MARK: Lifecycle
    
    init(authController: AuthControllable) {
        self.authController = authController
    }
    
    // MARK: Properties
    
    @MainActor private(set) var showProgressView: Bool = false
    
    private let authController: AuthControllable
}

extension LoginViewModel: LoginViewModelType {
    func signIn(with type: ThirdPartyLoginType) async throws {
        Task {
            await MainActor.run { [weak self] in
                self?.showProgressView = true
            }

            do {
                ///
                let result = await authController.trySignIn()
                //
            } catch {
                
            }
            
            await MainActor.run { [weak self] in
                self?.showProgressView = false
            }
        }
    }
}
