//
//  DependencyContainer.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import SwiftUI
import Feature
import Domain
import Repository
import Network

@MainActor final class DependencyContainer {
    
    // MARK: Properties
    
    let appState: GlobalAppState = .init()
    
    lazy var featureComponent = FeatureComponent(
        useCaseBuilder: useCaseBuilder,
        repositoryBuilder: repositoryBuilder,
        appState: appState
    )

    private lazy var useCaseBuilder: UseCaseBuilder = {
        UseCaseComponent(repositoryBuilder: repositoryBuilder)
    }()
    private lazy var repositoryBuilder: RepositoryBuilder = {
        RepositoryComponent(networkProvider: networkProvider)
    }()
    private let networkProvider: NetworkProvidable = NetworkProvider(configuration: NetworkConfiguration(baseURLString: AppKeys.baseURL))
    
    // MARK: Methods
    
    @ViewBuilder
    func buildRootView() -> some View {
        let viewModel = RootViewModel(useCase: useCaseBuilder.signInUseCase)
        RootView(
            viewModel: viewModel,
            signInBuilder: featureComponent.signInBuilder(),
            homeBuilder: featureComponent.homeBuilder(),
            newPostBuilder: featureComponent.newPostBuilder()
        )
    }
    
    func configure(tokenStore: TokenStorable) {
        Task {
            await networkProvider.setTokenStore(tokenStore)
        }
    }
}
