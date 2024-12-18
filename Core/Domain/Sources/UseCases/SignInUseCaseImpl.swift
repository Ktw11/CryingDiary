//
//  SignInUseCaseImpl.swift
//  Domain
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public actor SignInUseCaseImpl: SignInUseCase {
    
    // MARK: Lifecycle
    
    public init(repository: AuthRepository) {
        self.repository = repository
    }
    
    // MARK: Properties
    
    private let repository: AuthRepository
    
    public func signIn(type: String, token: String) async throws -> SignInResponse {
        return try await repository.signIn(token: token, type: type)
    }
}
