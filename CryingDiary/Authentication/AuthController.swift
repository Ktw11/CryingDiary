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
    
    private let networkProvider: NetworkProvidable
    private let loginInfoRepository: LoginInfoRepositoryType
    private let appleLoginHelper: ThirdPartyLoginHelpable
    private let kakaoLoginHelper: ThirdPartyLoginHelpable
}

extension AuthController: AuthControllable {
    func trySignIn() async -> SignInResponse? {
        guard let info = await loginInfoRepository.retrieve() else { return nil }
        guard let thirdPatryToken = await getThirdPartyAccessToken(info: info) else { return nil }
        
        let api = AuthAPI.signIn(token: thirdPatryToken, type: info.loginType)
        guard let response = try? await networkProvider.request(api: api, decodingType: SignInResponse.self) else { return nil }
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
        saveLoginInfo(thirdPatryToken: token, loginType: type)
        return response
    }
    
    func signOut() throws {
        #warning("로그아웃 구현 필요")
    }
}

private extension AuthController {
    func getThirdPartyAccessToken(info: LoginInfo) async -> String? {
        switch info.loginType {
        case .apple:
            ""
        case .kakao:
            await kakaoLoginHelper.getSavedToken()
        }
    }
    
    func saveLoginInfo(thirdPatryToken: String, loginType: ThirdPartyLoginType) {
        Task.detached { [loginInfoRepository] in
            try? await loginInfoRepository.save(
                info: .init(thirdPatryToken: thirdPatryToken, loginType: loginType)
            )
        }
    }
}
