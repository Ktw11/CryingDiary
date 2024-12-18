//
//  SignInResponse.swift
//  Network
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Domain

struct SignInResponseDTO: Decodable, Sendable {
    let user: UserDTO
    let accessToken: String
}

extension SignInResponseDTO {
    var toDomain: SignInResponse {
        .init(user: user.toDomain, accessToken: accessToken)
    }
}

