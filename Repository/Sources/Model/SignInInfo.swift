//
//  SignInInfo.swift
//  Repository
//
//  Created by 공태웅 on 11/29/24.
//

import Foundation

public struct SignInInfo: Sendable {
    public let refreshToken: String
    public let signInType: SignInType
    
    public init(refreshToken: String, signInType: SignInType) {
        self.refreshToken = refreshToken
        self.signInType = signInType
    }
}
