//
//  RootView.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/19/24.
//

import SwiftUI
import SignInInterface
import HomeInterface
import NewPostInterface

struct RootView<
    SignInComponent: SignInBuilder,
    HomeComponent: HomeBuilder,
    NewPostComponent: NewPostBuilder
>: View {
    
    // MARK: Lifecycle
    
    init(
        viewModel: RootViewModel,
        signInBuilder: SignInComponent,
        homeBuilder: HomeComponent,
        newPostBuilder: NewPostComponent
        
    ) {
        self.viewModel = viewModel
        self.signInBuilder = signInBuilder
        self.homeBuilder = homeBuilder
        self.newPostBuilder = newPostBuilder
    }

    // MARK: Properties

    private let viewModel: RootViewModel
    private let signInBuilder: SignInComponent
    private let homeBuilder: HomeComponent
    private let newPostBuilder: NewPostComponent
    
    var body: some View {
        ZStack {
            switch viewModel.scene {
            case .splash:
                #warning("스플래시 화면 교체 필요")
                Text("@@@ SPLASH")
                    .font(.largeTitle)
            case .signIn:
                signInBuilder.signInView() { response in
                    viewModel.setScene(to: .tabs(response))
                }
            case .tabs:
                RootTabView(homeBuilder: homeBuilder, newPostBuilder: newPostBuilder)
            }
        }
        .onAppear {
            viewModel.trySignIn()
        }
    }
}

#Preview {
    let featureComponent = DependencyContainer().featureComponent
    RootView(
        viewModel: RootViewModel(useCase: SignInUseCaseMock()),
        signInBuilder: featureComponent.signInBuilder(),
        homeBuilder: featureComponent.homeBuilder(),
        newPostBuilder: featureComponent.newPostBuilder()
    )
}
