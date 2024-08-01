//
//  FirebaseAuthManager.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/7/24.
//

import Foundation
@preconcurrency import FirebaseAuth

final class FirebaseAuthManager: AuthManagable {
    
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
    
    private let appleLoginHelper: ThirdPartyLoginHelpable
    private let state: State = .init()

    // MARK: Methods
    
    func signInWithApple() async throws {
        let info = try await appleLoginHelper.signIn()
        
        let credential = OAuthProvider.appleCredential(
            withIDToken: info.token,
            rawNonce: info.nonce,
            fullName: info.fullName
        )
        
        try await signIn(with: credential)
    }
}

private extension FirebaseAuthManager {
    func signIn(with credential: OAuthCredential) async throws {
        try await withCheckedThrowingContinuation { continuation in
            Task {
                await self.state.setAuthContinuation(to: continuation)

                do {
                    try await Auth.auth().signIn(with: credential)
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
