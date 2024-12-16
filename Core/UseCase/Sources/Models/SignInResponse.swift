//
//  SignInResponse.swift
//  UseCase
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Repository

public struct SignInResponse: Decodable, Sendable {
    public let user: User
    public let accessToken: String
}

extension SignInResponse {
    init(from dto: SignInResponseDTO) {
        self.user = User(from: dto.user)
        self.accessToken = dto.accessToken
    }
}
