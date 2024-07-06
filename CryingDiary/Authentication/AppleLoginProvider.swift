//
//  AppleLoginProvider.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/6/24.
//

import Foundation
import CryptoKit
import AuthenticationServices

final class AppleLoginProvider: NSObject {

    // MARK: Definitions
    
    private enum Constants {
        static let charSet: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    }
    
    // MARK: Properties
    
    private var currentNonce: String? = nil
    
    // MARK: Methods
    
    func signIn() {
        let nonce = makeNonce()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

private extension AppleLoginProvider {
    func makeNonce(count: Int = 32) -> String {
        precondition(count > 0)
        
        var randomBytes = [UInt8](repeating: 0, count: count)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        
        if errorCode != errSecSuccess {
            fatalError("[AppleLoginProvider] Failed for \(errorCode)")
        }
        
        let charSet: [Character] = Constants.charSet
        let nonce = randomBytes.map { byte in
            charSet[Int(byte) % charSet.count]
        }
        
        return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        
        return hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
    }
}

extension AppleLoginProvider: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        guard let nonce = currentNonce else { return }
        guard let token = credential.identityToken else { return }
        guard let tokenString = String(data: token, encoding: .utf8) else { return }

        // TODO: AuthManager에 결과를 넘겨주는 부분 구현 필요
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // TODO: 에러 대응 구현 필요
    }
}
