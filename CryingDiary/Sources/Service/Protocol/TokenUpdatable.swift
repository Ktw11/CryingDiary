//
//  TokenUpdatable.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/1/24.
//

import Foundation

protocol TokenUpdatable: Sendable {
    var accessToken: String? { get async }
    var refreshToken: String? { get async }
    
    func updateTokens(accessToken: String, refreshToken: String) async
    func reset() async
}
