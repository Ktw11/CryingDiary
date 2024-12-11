//
//  KakaoAuthHelper.swift
//  ThirdParty
//
//  Created by 공태웅 on 11/29/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

@MainActor
final class KakaoAuthHelper: ThirdPartyAuthHelpable {
    
    // MARK: Methods
    
    func configure() {
        KakaoSDK.initSDK(appKey: Environments.kakaoAppKey)
    }
    
    func handleURL(_ url: URL) -> Bool {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            _ = KakaoSDKAuth.AuthController.handleOpenUrl(url: url)
            return true
        }
        return false
    }
    
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

private extension KakaoAuthHelper {
    func login(completion: @escaping (Result<String, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithApp { completion($0) }
        } else {
            loginWithWeb { completion($0) }
        }
    }
    
    func loginWithApp(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.loginWithKakaoTalk { token, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let token else {
                completion(.failure(ThirdPartyHelperError.failedToGetToken))
                return
            }
            
            completion(.success(token.accessToken))
        }
    }
    
    func loginWithWeb(completion: @escaping (Result<String, Error>) -> Void) {
        UserApi.shared.loginWithKakaoAccount { token, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let token else {
                completion(.failure(ThirdPartyHelperError.failedToGetToken))
                return
            }
            
            completion(.success(token.accessToken))
        }
    }
}
