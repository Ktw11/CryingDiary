//
//  AuthController.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation

final actor AuthController {
    
    // MARK: Lifecycle
    
    init(
        networkProvider: NetworkProvidable,
        loginInfoRepository: LoginInfoRepositoryType,
        loginHelperFactory: LoginHelperFactoryType
    ) {
        self.networkProvider = networkProvider
        self.loginInfoRepository = loginInfoRepository
        self.loginHelperFactory = loginHelperFactory
    }
    
    // MARK: Properties
    
    private var loginType: ThirdPartyLoginType?
    private let networkProvider: NetworkProvidable
    private let loginInfoRepository: LoginInfoRepositoryType
    private let loginHelperFactory: LoginHelperFactoryType
}

extension AuthController: AuthControllable {
    func trySignIn() async -> SignInResponse? {
        guard let info = await loginInfoRepository.retrieve() else { return nil }

        let api = AuthAPI.autoSignIn(refreshToken: info.refreshToken)
        guard let response = try? await networkProvider.request(api: api, decodingType: SignInResponse.self) else { return nil }
        saveLoginInfo(refreshToken: response.user.refreshToken, loginType: info.loginType)
        loginType = info.loginType

        return response
    }
    
    func signIn(with type: ThirdPartyLoginType) async throws -> SignInResponse {
        let token = try await loginHelperFactory
            .getHelper(loginType: type)
            .getToken()
        
        let api = AuthAPI.signIn(token: token, type: type)
        let response = try await networkProvider.request(api: api, decodingType: SignInResponse.self)
        saveLoginInfo(refreshToken: response.user.refreshToken, loginType: type)
        loginType = type

        return response
    }
    
    func signOut() async throws {
        guard let loginType else { throw AuthControllerError.notFoundLoginType }
        
        resetLoginInfo()
        try await networkProvider.request(api: AuthAPI.signOut)
        try await loginHelperFactory
            .getHelper(loginType: loginType)
            .signOut()
    }
}

private extension AuthController {
    func saveLoginInfo(refreshToken: String, loginType: ThirdPartyLoginType) {
        Task.detached { [loginInfoRepository] in
            try? await loginInfoRepository.save(
                info: .init(refreshToken: refreshToken, loginType: loginType)
            )
        }
    }
    
    func resetLoginInfo() {
        Task.detached { [loginInfoRepository] in
            try? await loginInfoRepository.reset()
        }
    }
}
