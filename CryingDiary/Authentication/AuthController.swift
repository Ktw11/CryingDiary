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
        appleLoginHelper: ThirdPartyLoginHelpable,
        kakaoLoginHelper: ThirdPartyLoginHelpable
    ) {
        self.networkProvider = networkProvider
        self.loginInfoRepository = loginInfoRepository
        self.appleLoginHelper = appleLoginHelper
        self.kakaoLoginHelper = kakaoLoginHelper
    }
    
    // MARK: Properties
    
    private var loginType: ThirdPartyLoginType?
    private let networkProvider: NetworkProvidable
    private let loginInfoRepository: LoginInfoRepositoryType
    private let appleLoginHelper: ThirdPartyLoginHelpable
    private let kakaoLoginHelper: ThirdPartyLoginHelpable
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
        let token = switch type {
        case .apple:
            try await appleLoginHelper.getToken()
        case .kakao:
            try await kakaoLoginHelper.getToken()
        }
        
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
        
        switch loginType {
        case .apple:
            try await appleLoginHelper.signOut()
        case .kakao:
            try await kakaoLoginHelper.signOut()
        }
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
