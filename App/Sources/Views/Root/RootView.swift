//
//  RootView.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/19/24.
//

import SwiftUI
import SignInInterface
import HomeInterface

struct RootView<SignInComponent: SignInBuilder, HomeComponent: HomeBuilder>: View {
    
    // MARK: Lifecycle
    
    init(
        viewModel: RootViewModel,
        signInBuilder: SignInComponent,
        homeBuilder: HomeComponent
    ) {
        self.viewModel = viewModel
        self.signInBuilder = signInBuilder
        self.homeBuilder = homeBuilder
    }

    // MARK: Properties

    private let viewModel: RootViewModel
    private let signInBuilder: SignInComponent
    private let homeBuilder: HomeComponent
    
    var body: some View {
        ZStack {
            switch viewModel.scene {
            case .splash:
                #warning("스플래시 화면 교체 필요")
                Text("@@@ SPLASH")
                    .font(.largeTitle)
            case .signIn:
                signInBuilder.signInView() { response in
                    viewModel.setScene(to: .main(response))
                }
            case .main:
                homeBuilder.homeView()
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
        signInBuilder: DependencyContainer().featureComponent.signInBuilder(),
        homeBuilder: DependencyContainer().featureComponent.homeBuilder()
    )
}
