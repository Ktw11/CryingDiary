//
//  AppleLoginHelper.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/6/24.
//

import Foundation
import AuthenticationServices

final class AppleLoginHelper: NSObject, ThirdPartyLoginHelpable {

    // MARK: Properties
    
    private var currentNonce: String? = nil
    private var authContinuation: CheckedContinuation<ASAuthorization, Error>?
    
    // MARK: Methods
    
    func signIn() async throws -> AppleLoginInfo {
        let authorization = try await getAuthorizationFromApple()
        return try await getLoginInfo(from: authorization)
    }
}

private extension AppleLoginHelper {
    func getAuthorizationFromApple() async throws -> ASAuthorization {
        try await withCheckedThrowingContinuation { continuation in
            self.authContinuation = continuation
            self.performAuthRequest()
        }
    }
    
    func performAuthRequest() {
        let nonce = CryptoUtil.makeRandomNonce()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = CryptoUtil.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }

    func getLoginInfo(from authorization: ASAuthorization) async throws -> AppleLoginInfo {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let token = credential.identityToken,
              let tokenString = String(data: token, encoding: .utf8) else {
            throw ThirdPartyLoginError.failedToAuthentication
        }
        
        return AppleLoginInfo(
            token: tokenString,
            nonce: nonce,
            fullName: credential.fullName
        )
    }
}

extension AppleLoginHelper: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        authContinuation?.resume(returning: authorization)
        authContinuation = nil
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        authContinuation?.resume(throwing: error)
        authContinuation = nil
    }
}
