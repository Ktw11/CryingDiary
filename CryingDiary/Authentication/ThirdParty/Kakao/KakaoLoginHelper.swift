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
final class KakaoLoginHelper: EmailLoginHelpable {
    
    // MARK: Methods
    
    func signIn() async throws -> EmailLoginResult {
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
    func loginWithToken(completion: @escaping (Result<EmailLoginResult, Error>) -> Void) {
        UserApi.shared.accessTokenInfo { _, error in
            if let _ = error {
                self.loginWithService { completion($0) }
            } else {
                self.getLoginResult { completion($0) }
            }
        }
    }
    
    func loginWithService(completion: @escaping (Result<EmailLoginResult, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithApp { completion($0) }
        } else {
            loginWithWeb { completion($0) }
        }
    }
    
    func loginWithApp(completion: @escaping (Result<EmailLoginResult, Error>) -> Void) {
        UserApi.shared.loginWithKakaoTalk { token, error in
            guard error == nil, token != nil else {
                completion(.failure(ThirdPartyLoginError.failedToAuthentication))
                return
            }
            
            self.getLoginResult { completion($0) }
        }
    }
    
    @MainActor
    func loginWithWeb(completion: @escaping (Result<EmailLoginResult, Error>) -> Void) {
        UserApi.shared.loginWithKakaoAccount { token, error in
            guard error == nil, token != nil else {
                completion(.failure(ThirdPartyLoginError.failedToAuthentication))
                return
            }
            
            self.getLoginResult { completion($0) }
        }
    }
    
    func getLoginResult(completion: @escaping (Result<EmailLoginResult, Error>) -> Void) {
        UserApi.shared.me { user, error in
            guard error == nil else {
                completion(.failure(ThirdPartyLoginError.failedToAuthentication))
                return
            }
            guard let email = user?.kakaoAccount?.email,
                  let userId = user?.id else {
                completion(.failure(ThirdPartyLoginError.invalidUserInfo))
                return
            }
            
            let info = EmailLoginResult(email: email, password: String(userId))
            completion(.success(info))
        }
    }
}
