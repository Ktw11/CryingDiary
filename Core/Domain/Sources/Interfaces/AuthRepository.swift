//
//  AuthRepository.swift
//  Domain
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public protocol AuthRepository: Sendable {
    func signIn(token: String, type: String) async throws -> SignInResponse
    func signIn(refreshToken: String) async throws -> SignInResponse
}
