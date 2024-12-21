//
//  Dependency+SignIn.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI
import Domain
import SignIn

extension DependencyContainer: SignInBuilder {
    @ViewBuilder func signInView(didSignIn: @escaping ((SignInResponse) -> Void)) -> some View {
        let viewModel = SignInViewModel(
            signInTypes: [.apple, .kakao],
            useCase: signInUseCase,
            didSignIn: didSignIn
        )
        SignInView(viewModel: viewModel)
    }
}
