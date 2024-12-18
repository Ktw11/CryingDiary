//
//  AuthRepositoryImpl.swift
//  Repository
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Network
import Domain

public actor AuthRepositoryImpl: AuthRepository {
    
    // MARK: Lifecycle
    
    public init(networkProvider: NetworkProvidable) {
        self.networkProvider = networkProvider
    }
    
    // MARK: Properties
    
    private let networkProvider: NetworkProvidable
    
    public func signIn(token: String, type: String) async throws -> SignInResponse {
        let api = AuthAPI.signIn(token: token, type: type)
        return try await networkProvider.request(api: api, decodingType: SignInResponseDTO.self).toDomain
    }
}
