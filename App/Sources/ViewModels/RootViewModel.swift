//
//  RootViewModel.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/19/24.
//

import Foundation
import Domain

@Observable
@MainActor
final class RootViewModel {
    
    public init(useCase: SignInUseCase) {
        self.useCase = useCase
    }

    // MARK: Properties
    
    private(set) var scene: AppScene = .splash
    private let useCase: SignInUseCase
    
    func trySignIn() {
        Task { [weak self, useCase] in
            if let result = await useCase.signInWithSavedToken() {
                self?.scene = .tabs(result)
            } else {
                self?.scene = .signIn
            }
        }
    }
    
    func setScene(to scene: AppScene) {
        self.scene = scene
    }
}
