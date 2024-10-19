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
        var currentNonce: String? = nil
        var authContinuation: CheckedContinuation<ASAuthorization, Error>? = nil
        
        func setNonce(to nonce: String?) {
            currentNonce = nonce
        }
        
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
        await state.setNonce(to: nonce)
        
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
              let nonce = await state.currentNonce,
              let token = credential.identityToken,
              let tokenString = String(data: token, encoding: .utf8) else {
            throw ThirdPartyLoginError.failedToAuthentication
        }
        return tokenString
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
