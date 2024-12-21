//
//  SignInUseCaseImpl.swift
//  Domain
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public actor SignInUseCaseImpl: SignInUseCase {
    
    // MARK: Lifecycle
    
    public init(
        authRepository: AuthRepository,
        signInInfoRepository: SignInInfoRepository
    ) {
        self.authRepository = authRepository
        self.signInInfoRepository = signInInfoRepository
    }
    
    // MARK: Properties
    
    private let authRepository: AuthRepository
    private let signInInfoRepository: SignInInfoRepository

    public func signInWithSavedToken() async -> SignInResponse? {
        guard let info = await signInInfoRepository.retrieve() else { return nil }
        guard let response = try? await authRepository.signIn(refreshToken: info.refreshToken) else { return nil }
        updateSignInInfo(response, signInType: info.signInType)
        
        return response
    }
    
    public func signIn(type: String, token: String) async throws -> SignInResponse {
        let response = try await authRepository.signIn(token: token, type: type)
        
        updateSignInInfo(response, signInType: type)
        return response
    }
}

private extension SignInUseCaseImpl {
    func updateSignInInfo(_ response: SignInResponse, signInType: String) {
        Task.detached { [signInInfoRepository] in
            let refreshToken = response.user.refreshToken

            try? await signInInfoRepository.save(
                info: .init(refreshToken: refreshToken, signInType: signInType)
            )
        }
    }
}
