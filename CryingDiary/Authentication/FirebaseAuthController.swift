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
    
    init(
        appleLoginHelper: AppleLoginHelpable,
        kakaoLoginHelper: EmailLoginHelpable
    ) {
        self.appleLoginHelper = appleLoginHelper
        self.kakaoLoginHelper = kakaoLoginHelper
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
    private let appleLoginHelper: AppleLoginHelpable
    private let kakaoLoginHelper: EmailLoginHelpable
    private let state: State = .init()

    // MARK: Methods
    
    func signIn(with type: ThirdPartyLoginType) async throws {
        switch type {
        case .apple:
            try await signInWithApple()
        case .kakao:
            try await signInKakao()
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
    
    func signInKakao() async throws {
        let result = try await kakaoLoginHelper.signIn()
        do {
            try await signIn(email: result.email, password: result.password)
        } catch {
            throw error
        }
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
    
    func signIn(email: String, password: String) async throws {
        do {
            try await auth.createUser(withEmail: email, password: password)
        } catch {
            try await handleCreateUserError(error, email: email, password: password)
        }
    }
    
    func handleCreateUserError(_ error: Error, email: String, password: String) async throws {
        let firebaseErrorCode = AuthErrorCode(_nsError: (error as NSError)).code
        
        if firebaseErrorCode == .emailAlreadyInUse {
            try await auth.signIn(withEmail: email, password: password)
            return
        } else {
            throw error
        }
    }
}
