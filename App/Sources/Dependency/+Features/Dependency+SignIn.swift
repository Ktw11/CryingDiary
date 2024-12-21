//
//  Dependency+SignIn.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI
import SignIn

extension DependencyContainer: SignInBuilder {
    @ViewBuilder func signInView() -> some View {
        let viewModel = SignInViewModel(
            signInTypes: [.apple, .kakao],
            useCase: signInUseCase
        )
        SignInView(viewModel: viewModel)
    }
}
