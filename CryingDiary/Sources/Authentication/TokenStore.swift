//
//  TokenStore.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/29/24.
//

import Foundation

protocol TokenStorable: Sendable {
    var accessToken: String? { get async }
    var refreshToken: String? { get async }
    
    func updateTokens(accessToken: String, refreshToken: String) async
}

final actor TokenStore: TokenStorable {

    // MARK: Properties
    
    private(set) var accessToken: String?
    private(set) var refreshToken: String?
    
    // MARK: Methods
    
    func updateTokens(accessToken: String, refreshToken: String) async {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
