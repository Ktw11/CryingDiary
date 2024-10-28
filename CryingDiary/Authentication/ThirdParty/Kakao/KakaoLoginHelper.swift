//
//  KakaoLoginHelper.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/18/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
 
@MainActor
final class KakaoLoginHelper: ThirdPartyLoginHelpable {
    
    // MARK: Methods
    
    func getToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            login { result in
                switch result {
                case .success(let info):
                    continuation.resume(returning: info)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getSavedToken(needRequest: Bool) async -> String? {
        if let token = await retrieveToken() {
            return token
        } else if needRequest {
            return try? await getToken()
        } else {
            return nil
        }
    }
}

private extension KakaoLoginHelper {
    func login(completion: @escaping (Result<String, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithApp { completion($0) }
        } else {
            loginWithWeb { completion($0) }
        }
    }
    
    func loginWithApp(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.loginWithKakaoTalk { token, error in
            guard error == nil, let token else {
                completion(.failure(ThirdPartyLoginError.failedToAuthentication))
                return
            }
            
            completion(.success(token.accessToken))
        }
    }
    
    func loginWithWeb(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.loginWithKakaoAccount { token, error in
            guard error == nil, let token else {
                completion(.failure(ThirdPartyLoginError.failedToAuthentication))
                return
            }
            
            completion(.success(token.accessToken))
        }
    }
    
    func retrieveToken() async -> String? {
        guard let token = TokenManager.manager.getToken() else { return nil }
        guard !token.isAccessTokenExpired else { return token.accessToken }
        
        return await withCheckedContinuation { continuation in
            AuthApi.shared.refreshToken { token, error in
                if error == nil, let token {
                    continuation.resume(returning: token.accessToken)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}

private extension OAuthToken {
    var isAccessTokenExpired: Bool {
        return expiredAt < Date()
    }
}
