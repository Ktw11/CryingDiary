//
//  SignInInfoDTO.swift
//  Repository
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation
import SwiftData

@Model
final class SignInInfoDTO {
    @Attribute(.unique) var refreshToken: String
    var signInType: String
    
    init(refreshToken: String, signInType: String) {
        self.refreshToken = refreshToken
        self.signInType = signInType
    }
}
