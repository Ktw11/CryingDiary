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
    
    func signOut() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            UserApi.shared.logout { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: Void())
                }
            }
        }
    }
    
    func unlink() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            UserApi.shared.unlink { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: Void())
                }
            }
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
}
