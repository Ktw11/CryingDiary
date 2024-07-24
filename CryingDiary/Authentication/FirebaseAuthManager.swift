//
//  FirebaseAuthManager.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/7/24.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager: AuthManagable {
    
    // MARK: Definitions
    
    private actor State {
        var isLoading: Bool = false
        
        func setIsLoading(to value: Bool) {
            isLoading = value
        }
    }
    
    // MARK: Properties
    
    private var authContinuation: CheckedContinuation<Void, Error>?
    private let state: State = .init()

    // MARK: Methods
    
    func signInWithApple(
        token: String,
        nonce: String?,
        fullName: PersonNameComponents?
    ) async throws {
        guard await !state.isLoading else { return }
        await state.setIsLoading(to: true)

        let credential = OAuthProvider.appleCredential(
            withIDToken: token,
            rawNonce: nonce,
            fullName: fullName
        )
        
        try await run {
            try await signIn(with: credential)
        } defer: {
            await state.setIsLoading(to: false)
        }
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
