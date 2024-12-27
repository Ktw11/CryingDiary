//
//  FeatureComponent+SignIn.swift
//  Feature
//
//  Created by 공태웅 on 12/26/24.
//

import SwiftUI
import SignIn
import SignInInterface

extension FeatureComponent {
    public func signInBuilder() -> some SignInBuilder {
        SignInComponent(
            dependency: .init(
                signInTypes: [.apple, .kakao],
                useCase: useCaseBuilder.signInUseCase,
                appState: appState
            )
        )
    }
}
