//
//  UseCaseComponent.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/27/24.
//

import Foundation
import Feature
import Domain

final class UseCaseComponent: UseCaseBuilder {
    
    init(repositoryBuilder: RepositoryBuilder) {
        self.repositoryBuilder = repositoryBuilder
    }
    
    private let repositoryBuilder: RepositoryBuilder
    
    var signInUseCase: SignInUseCase {
        SignInUseCaseImpl(
            authRepository: repositoryBuilder.authRepository,
            signInInfoRepository: repositoryBuilder.signInInfoRepository
        )
    }
}
