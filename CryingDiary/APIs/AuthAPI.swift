//
//  AuthAPI.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation

enum AuthAPI: API {
    case signIn(token: String, type: ThirdPartyLoginType)
    case autoSignIn(refreshToken: String)
    case signOut(userId: String, token: String, type: ThirdPartyLoginType)
}

extension AuthAPI {
    var path: String {
        switch self {
        case let .signIn(_, loginType):
            "auth/signIn/\(loginType.rawValue)"
        case .autoSignIn:
            "auth/autoSignIn"
        case let .signOut(_, _, loginType):
            "auth/signOut/\(loginType.rawValue)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .signIn, .autoSignIn, .signOut:
            .post
        }
    }

    var bodyParameters: [String: String]? {
        switch self {
        case let .signIn(token, _):
            return ["token": token]
        case let .autoSignIn(refreshToken):
            return ["refreshToken": refreshToken]
        case let .signOut(userId, token, _):
            return ["token": token, "userId": userId]
        }
    }

    var needsAuthorization: Bool {
        switch self {
        case .signIn, .autoSignIn:
            false
        case .signOut:
            true
        }
    }
}
