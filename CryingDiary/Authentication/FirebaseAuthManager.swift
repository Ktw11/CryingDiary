//
//  FirebaseAuthManager.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/7/24.
//

import Foundation
import FirebaseAuth

final actor FirebaseAuthManager: AuthManagable {
    
    // MARK: Methods
    
    func signIn(
        token: String,
        nonce: String?,
        fullName: PersonNameComponents?
    ) async throws -> String? {
        try await withCheckedThrowingContinuation { continuation in
            let credential = OAuthProvider.appleCredential(
                withIDToken: token,
                rawNonce: nonce,
                fullName: fullName
            )
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                // TODO: - User 정보를 담은 객체를 리턴하도록 수정 필요
                continuation.resume(returning: result?.user.displayName)
            }
        }
    }
}
