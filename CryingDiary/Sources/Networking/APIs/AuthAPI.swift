//
//  AuthAPI.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation
import Network

enum AuthAPI: API {
    case signIn(token: String, type: SignInType)
    case autoSignIn(refreshToken: String)
    case signOut
    case unlink
}

extension AuthAPI {
    var path: String {
        switch self {
        case let .signIn(_, signInType):
            "auth/signIn/\(signInType.rawValue)"
        case .autoSignIn:
            "auth/autoSignIn"
        case .signOut:
            "auth/signOut"
        case .unlink:
            "auth/unlink"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .signIn, .autoSignIn, .signOut, .unlink:
            .post
        }
    }

    var bodyParameters: [String: String]? {
        switch self {
        case let .signIn(token, _):
            return ["token": token]
        case let .autoSignIn(refreshToken):
            return ["refreshToken": refreshToken]
        case .signOut, .unlink:
            return nil
        }
    }

    var needsAuthorization: Bool {
        switch self {
        case .signIn, .autoSignIn:
            false
        case .signOut, .unlink:
            true
        }
    }
}
