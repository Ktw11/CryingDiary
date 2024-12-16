//
//  SignInResponse.swift
//  Network
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public struct SignInResponseDTO: Decodable, Sendable {
    public let user: UserDTO
    public let accessToken: String
}
