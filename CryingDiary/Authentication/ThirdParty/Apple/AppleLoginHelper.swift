//
//  AppleLoginHelper.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/6/24.
//

import Foundation
import AuthenticationServices

final class AppleLoginHelper: NSObject, ThirdPartyLoginHelpable {
    
    // MARK: Definitions
    
    private actor State {
        var authContinuation: CheckedContinuation<ASAuthorization, Error>? = nil

        func setAuthContinuation(to continuation: CheckedContinuation<ASAuthorization, Error>?) {
            authContinuation = continuation
        }
    }

    // MARK: Properties

    private let state: State = .init()
    
    // MARK: Methods
    
    func getToken() async throws -> String {
        let authorization = try await getAuthorizationFromApple()
        return try await getLoginInfo(from: authorization)
    }
    
    func getSavedToken(needRequest: Bool) async -> String? {
        // 이떄부턴 Apple Refresh Token을 사용하자
        // 이 아니고, 우리서버의 ACCESS, REFRESH를 사용해야지
        // 카카오도 수정해야지
        #warning("자동 로그인 구현 필요")
        return ""
    }
}

private extension AppleLoginHelper {
    func getAuthorizationFromApple() async throws -> ASAuthorization {
        try await withCheckedThrowingContinuation { continuation in
            Task {
                await self.state.setAuthContinuation(to: continuation)
                await self.performAuthRequest()
            }
        }
    }
    
    func performAuthRequest() async {
        let nonce = CryptoUtil.makeRandomNonce()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = CryptoUtil.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }

    func getLoginInfo(from authorization: ASAuthorization) async throws -> String {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let authCodeData = credential.authorizationCode,
              let authCodeString = String(data: authCodeData, encoding: .utf8) else {
            throw ThirdPartyLoginError.failedToAuthentication
        }
        return authCodeString
    }
}

extension AppleLoginHelper: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        Task {
            await self.state.authContinuation?.resume(returning: authorization)
            await self.state.setAuthContinuation(to: nil)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Task {
            await self.state.authContinuation?.resume(throwing: error)
            await self.state.setAuthContinuation(to: nil)
        }
    }
}
