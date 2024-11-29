//
//  TokenStore.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/29/24.
//

import Foundation

final actor TokenStore {

    // MARK: Properties
    
    private(set) var accessToken: String?
    private(set) var refreshToken: String?
    
    // MARK: Methods
    
    func updateTokens(accessToken: String, refreshToken: String) async {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
