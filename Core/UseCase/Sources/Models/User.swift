//
//  User.swift
//  UseCase
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Repository

public struct User: Decodable, Sendable {
    public let id: String
    public let loginType: String
    public let refreshToken: String
}

extension User {
    init(from dto: UserDTO) {
        self.id = dto.id
        self.loginType = dto.loginType
        self.refreshToken = dto.refreshToken
    }
}
