//
//  SignInResponse.swift
//  Domain
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public struct SignInResponse: Decodable, Sendable {
    public let user: User
    public let accessToken: String
    
    public init(user: User, accessToken: String) {
        self.user = user
        self.accessToken = accessToken
    }
}
