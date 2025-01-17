//
//  ThirdPartyLoginHelpable.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/6/24.
//

import Foundation

protocol ThirdPartyLoginHelpable: Sendable {
    func signIn() async throws -> AppleLoginInfo
}
