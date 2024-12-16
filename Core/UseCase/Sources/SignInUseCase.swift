//
//  SignInUseCase.swift
//  UseCase
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Repository

public protocol SignInUseCase {
    func signIn(with type: SignInType) async throws -> SignInResponse
}

public actor SignInUseCaseImpl {
    
    // MARK: Lifecycle
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    // MARK: Properties
    
    private let repository: AuthRepository
    
    public func signIn(token: String, type: SignInType) async throws -> SignInResponse {
        let dto = try await repository.signIn(token: token, type: type.rawValue)
        return SignInResponse(from: dto)
    }
}
