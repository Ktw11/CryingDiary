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
        let signInMethod = AuthApi.hasToken() ? loginWithToken : loginWithService
        
        return try await withCheckedThrowingContinuation { continuation in
            signInMethod { result in
                switch result {
                case .success(let info):
                    continuation.resume(returning: info)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

private extension KakaoLoginHelper {
    func loginWithToken(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.accessTokenInfo { tokenInfo, error in
            if let _ = error {
                self.loginWithService { completion($0) }
            } else if let tokenInfo, let id = tokenInfo.id.flatMap(String.init) {
                completion(.success(id))
            } else {
                self.loginWithService { completion($0) }
            }
        }
    }
    
    func loginWithService(completion: @escaping (Result<String, Error>) -> Void) {
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
}
