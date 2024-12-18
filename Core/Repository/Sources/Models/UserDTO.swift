//
//  UserDTO.swift
//  Network
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Domain

struct UserDTO: Decodable, Sendable {
    let id: String
    let loginType: String
    let refreshToken: String
}

extension UserDTO {
    var toDomain: User {
        .init(id: id, loginType: loginType, refreshToken: refreshToken)
    }
}
