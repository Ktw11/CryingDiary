//
//  AppleLoginHelpable.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/24/24.
//

import Foundation

protocol AppleLoginHelpable: Sendable {
    func signIn() async throws -> AppleLoginInfo
}
