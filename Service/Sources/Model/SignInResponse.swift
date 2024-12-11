//
//  SignInResponse.swift
//  Service
//
//  Created by 공태웅 on 9/29/24.
//

import Foundation

public struct SignInResponse: Decodable, Sendable {
    public let user: User
    public let accessToken: String
}
