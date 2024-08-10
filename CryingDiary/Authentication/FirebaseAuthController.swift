//
//  FirebaseAuthController.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation
@preconcurrency import FirebaseAuth

final class FirebaseAuthController: AuthControllable {
    
    // MARK: Lifecycle
    
    init(appleLoginHelper: ThirdPartyLoginHelpable) {
        self.appleLoginHelper = appleLoginHelper
    }
    
    // MARK: Definitions
    
    private actor State {
        var authContinuation: CheckedContinuation<Void, Error>?
        
        func setAuthContinuation(to continuation: CheckedContinuation<Void, Error>?) {
            authContinuation = continuation
        }
    }
    
    // MARK: Properties
    
    private let auth: Auth = Auth.auth()
    private let appleLoginHelper: ThirdPartyLoginHelpable
    private let state: State = .init()

    // MARK: Methods
    
    func signIn(with type: ThirdPartyLoginType) async throws {
        switch type {
        case .apple:
            try await signInWithApple()
        case .kakao:
            // TODO: KAKAO 로그인 구현 필요
            assertionFailure()
        }
    }
    
    func signOut() throws {
        try auth.signOut()
    }
}

private extension FirebaseAuthController {
    func signInWithApple() async throws {
        let info = try await appleLoginHelper.signIn()
        
        let credential = OAuthProvider.appleCredential(
            withIDToken: info.token,
            rawNonce: info.nonce,
            fullName: info.fullName
        )
        
        try await signIn(with: credential)
    }
    
    func signIn(with credential: OAuthCredential) async throws {
        try await withCheckedThrowingContinuation { continuation in
            Task { @MainActor in
                await self.state.setAuthContinuation(to: continuation)

                do {
                    try await self.auth.signIn(with: credential)
                    await self.state.authContinuation?.resume()
                    await self.state.setAuthContinuation(to: nil)
                } catch {
                    await self.state.authContinuation?.resume(throwing: error)
                    await self.state.setAuthContinuation(to: nil)
                }
            }
        }
    }
}
