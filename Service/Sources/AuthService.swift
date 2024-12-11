//
//  AuthService.swift
//  Service
//
//  Created by 공태웅 on 11/29/24.
//

import Foundation
import Network
import ThirdPartyAuth
import Repository

public protocol AuthServiceProtocol: Sendable {
    func trySignIn() async -> SignInResponse?
    func signIn(with type: SignInType) async throws -> SignInResponse
    func signOut() async throws
    func unlink() async throws
}

public actor AuthService {
    
    // MARK: Lifecycle
    
    public init(
        networkProvider: NetworkProvidable,
        signInInfoRepository: SignInInfoRepositoryType,
        tokenStore: TokenUpdatable
    ) {
        self.networkProvider = networkProvider
        self.signInInfoRepository = signInInfoRepository
        self.tokenStore = tokenStore
    }
    
    // MARK: Properties
    
    private let networkProvider: NetworkProvidable
    private let signInInfoRepository: SignInInfoRepositoryType
    private let tokenStore: TokenUpdatable
}

extension AuthService: AuthServiceProtocol {
    public func trySignIn() async -> SignInResponse? {
        guard let info = await signInInfoRepository.retrieve() else { return nil }
        
        let api = AuthAPI.autoSignIn(refreshToken: info.refreshToken)
        guard let response = try? await networkProvider.request(api: api, decodingType: SignInResponse.self) else { return nil }
        
        updateAuthInfo(response, signInType: info.signInType)
        
        return response
    }
    
    public func signIn(with type: SignInType) async throws -> SignInResponse {
        guard let thirdPartyType = ThirdPartyType(rawValue: type.rawValue) else {
            throw AuthServiceError.invalidSignInType
        }
        
        let token = try await ThirdPartyAuthProvider.getToken(type: thirdPartyType)
        let api = AuthAPI.signIn(token: token, type: type)
        let response = try await networkProvider.request(api: api, decodingType: SignInResponse.self)
        
        updateAuthInfo(response, signInType: type)
        
        return response
    }
    
    public func signOut() async throws {
        guard let info = await signInInfoRepository.retrieve() else { throw AuthServiceError.signInInfoNotFound }
        guard let thirdPartyType = ThirdPartyType(rawValue: info.signInType.rawValue) else {
            throw AuthServiceError.invalidSignInType
        }
        
        try await networkProvider.request(api: AuthAPI.signOut)
        try await ThirdPartyAuthProvider.signOut(type: thirdPartyType)
        resetAuthInfos()
    }
    
    public func unlink() async throws {
        guard let info = await signInInfoRepository.retrieve() else { throw AuthServiceError.signInInfoNotFound }
        guard let thirdPartyType = ThirdPartyType(rawValue: info.signInType.rawValue) else {
            throw AuthServiceError.invalidSignInType
        }
        
        try await networkProvider.request(api: AuthAPI.unlink)
        try await ThirdPartyAuthProvider.unlink(type: thirdPartyType)
        resetAuthInfos()
    }
}

private extension AuthService {
    func updateAuthInfo(_ response: SignInResponse, signInType: SignInType) {
        Task.detached { [signInInfoRepository, tokenStore] in
            let accessToken = response.accessToken
            let refreshToken = response.user.refreshToken

            async let saveInfo: Void? = try? await signInInfoRepository.save(
                info: .init(refreshToken: refreshToken, signInType: signInType)
            )
            async let updateTokens: Void = await tokenStore.updateTokens(accessToken: accessToken, refreshToken: refreshToken)
            
            _ = await saveInfo
            _ = await updateTokens
        }
    }
    
    
    func resetAuthInfos() {
        Task.detached { [signInInfoRepository, tokenStore] in
            async let resetRepo: Void? = try? await signInInfoRepository.reset()
            async let resetTokens: Void = await tokenStore.reset()
            
            _ = await resetRepo
            _ = await resetTokens
        }
    }
}
