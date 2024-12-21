//
//  SignInInfo.swift
//  Repository
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation

public struct SignInInfo: Sendable {
    public let refreshToken: String
    public let signInType: String
    
    public init(refreshToken: String, signInType: String) {
        self.refreshToken = refreshToken
        self.signInType = signInType
    }
}
