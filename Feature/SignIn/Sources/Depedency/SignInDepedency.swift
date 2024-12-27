//
//  SignInDepedency.swift
//  SignIn
//
//  Created by 공태웅 on 12/26/24.
//

import Foundation
import Domain

public struct SignInDependency {
    let signInTypes: [SignInType]
    let useCase: SignInUseCase
    let appState: AppStateUpdatable
    
    public init(
        signInTypes: [SignInType],
        useCase: SignInUseCase,
        appState: AppStateUpdatable
    ) {
        self.signInTypes = signInTypes
        self.useCase = useCase
        self.appState = appState
    }
}
