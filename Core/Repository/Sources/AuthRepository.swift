//
//  AuthRepository.swift
//  Repository
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Network

public protocol AuthRepository: Sendable {
    func signIn(token: String, type: String) async throws -> SignInResponseDTO
}

actor AuthRepositoryImpl: AuthRepository {
    
    // MARK: Lifecycle
    
    init(networkProvider: NetworkProvidable) {
        self.networkProvider = networkProvider
    }
    
    // MARK: Properties
    
    private let networkProvider: NetworkProvidable
    
    func signIn(token: String, type: String) async throws -> SignInResponseDTO {
        let api = AuthAPI.signIn(token: token, type: type)
        return try await networkProvider.request(api: api, decodingType: SignInResponseDTO.self)
    }
}
