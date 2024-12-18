//
//  User.swift
//  Domain
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public struct User: Decodable, Sendable {
    public let id: String
    public let loginType: String
    public let refreshToken: String
    
    public init(id: String, loginType: String, refreshToken: String) {
        self.id = id
        self.loginType = loginType
        self.refreshToken = refreshToken
    }
}