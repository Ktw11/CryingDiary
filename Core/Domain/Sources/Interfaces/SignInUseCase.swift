//
//  SignInUseCase.swift
//  Domain
//
//  Created by 공태웅 on 12/18/24.
//

import Foundation

public protocol SignInUseCase {
    func signInWithSavedToken() async -> SignInResponse?
    func signIn(type: String, token: String) async throws -> SignInResponse
}
