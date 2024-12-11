//
//  User.swift
//  Service
//
//  Created by 공태웅 on 8/11/24.
//

import Foundation

public struct User: Decodable, Sendable {
    public let id: String
    public let loginType: String
    public let refreshToken: String
}
