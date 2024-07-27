//
//  FirebaseAuthManager.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/7/24.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager: AuthManagable {
    
    // MARK: Lifecycle
    
    init(appleLoginHelper: ThirdPartyLoginHelpable) {
        self.appleLoginHelper = appleLoginHelper
    }
    
    // MARK: Properties
    
    private let appleLoginHelper: ThirdPartyLoginHelpable
    private var authContinuation: CheckedContinuation<Void, Error>?

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
            self.authContinuation = continuation
            
            Auth.auth().signIn(with: credential) { _, error in
                if let error = error {
                    self.authContinuation?.resume(throwing: error)
                    self.authContinuation = nil
                    return
                }

                self.authContinuation?.resume()
                self.authContinuation = nil
            }
        }
    }
}
