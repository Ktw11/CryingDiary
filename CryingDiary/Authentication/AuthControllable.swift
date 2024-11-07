//
//  AuthControllable.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation

protocol AuthControllable: Sendable, AnyObject {
    func trySignIn() async -> SignInResponse?
    func signIn(with type: ThirdPartyLoginType) async throws -> SignInResponse
    func signOut() async throws
}
