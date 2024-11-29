//
//  TokenStorable.swift
//  Network
//
//  Created by 공태웅 on 11/24/24.
//

import Foundation

public protocol TokenStorable: Sendable {
    var accessToken: String? { get async }
    var refreshToken: String? { get async }
    
    func updateTokens(accessToken: String, refreshToken: String) async
}
