//
//  UserDTO.swift
//  Network
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation

public struct UserDTO: Decodable, Sendable {
    public let id: String
    public let loginType: String
    public let refreshToken: String
}
