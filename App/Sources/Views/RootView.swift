//
//  RootView.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/19/24.
//

import SwiftUI
import SignIn

struct RootView<Builder: SignInBuilder>: View {
    
    // MARK: Lifecycle
    
    init(viewModel: RootViewModel, signInBuilder: Builder) {
        self.viewModel = viewModel
        self.signInBuilder = signInBuilder
    }

    // MARK: Properties

    private let viewModel: RootViewModel
    private let signInBuilder: Builder
    
    var body: some View {
        ZStack {
            switch viewModel.scene {
            case .splash:
                #warning("스플래시 화면 교체 필요")
                Text("@@@ SPLASH")
                    .font(.largeTitle)
            case .signIn:
                signInBuilder.signInView()
            case .home:
                #warning("홈 화면 교체 필요")
                Text("@@@ HOME")
                    .font(.largeTitle)
            }
        }
        .onAppear {
            viewModel.trySignIn()
        }
    }
}

#Preview {
    RootView(
        viewModel: RootViewModel(useCase: SignInUseCaseMock()),
        signInBuilder: DependencyContainer.previewDefault
    )
}
