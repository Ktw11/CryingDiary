//
//  FeatureComponent.swift
//  Feature
//
//  Created by 공태웅 on 12/11/24.
//

import SwiftUI
import Domain

final public class FeatureComponent {
    
    // MARK: Lifecycle
    
    public init(
        useCaseBuilder: UseCaseBuilder,
        repositoryBuilder: RepositoryBuilder,
        appState: AppStateUpdatable
    ) {
        self.useCaseBuilder = useCaseBuilder
        self.repositoryBuilder = repositoryBuilder
        self.appState = appState
    }
    
    // MARK: Properties
    
    let useCaseBuilder: UseCaseBuilder
    let repositoryBuilder: RepositoryBuilder
    let appState: AppStateUpdatable
}
