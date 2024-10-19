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
        tokenStore: TokenStorable,
        loginInfoRepository: LoginInfoRepositoryType,
        appleLoginHelper: ThirdPartyLoginHelpable,
        kakaoLoginHelper: ThirdPartyLoginHelpable
    ) {
        self.networkProvider = networkProvider
        self.tokenStore = tokenStore
        self.loginInfoRepository = loginInfoRepository
        self.appleLoginHelper = appleLoginHelper
        self.kakaoLoginHelper = kakaoLoginHelper
    }
    
    // MARK: Properties
    
    private let networkProvider: NetworkProvidable
    private let tokenStore: TokenStorable
    private let loginInfoRepository: LoginInfoRepositoryType
    private let appleLoginHelper: ThirdPartyLoginHelpable
    private let kakaoLoginHelper: ThirdPartyLoginHelpable
}

extension AuthController: AuthControllable {
    func trySignIn() async -> User? {
        guard let info = await loginInfoRepository.retrieve() else { return nil }
        let api = AuthAPI.signIn(token: info.thirdPatryToken, type: info.loginType)
        
        guard let response = try? await networkProvider.request(api: api, decodingType: SignInResponse.self) else { return nil }
        
        await tokenStore.updateTokens(accessToken: response.accessToken, refreshToken: response.user.refreshToken)
        return response.user
    }
    
    func signIn(with type: ThirdPartyLoginType) async throws {
        let token = switch type {
        case .apple:
            try await appleLoginHelper.getToken()
        case .kakao:
            try await kakaoLoginHelper.getToken()
        }
        
        #warning("로그인 반영 필요")
        let api = AuthAPI.signIn(token: token, type: type)
        let response = try await networkProvider.request(api: api, decodingType: SignInResponse.self)
//
        await tokenStore.updateTokens(accessToken: response.accessToken, refreshToken: response.user.refreshToken)
    }
    
    func signOut() throws {
        #warning("로그아웃 구현 필요")
    }
}
