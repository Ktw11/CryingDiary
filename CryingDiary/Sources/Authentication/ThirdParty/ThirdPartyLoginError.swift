//
//  ThirdPartyLoginError.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/14/24.
//

import Foundation

enum ThirdPartyLoginError: Error {
    case failedToAuthentication
    case invalidUserInfo
    case unknown
}
