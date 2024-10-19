//
//  AuthAPI.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation

enum AuthAPI: API {
    case signIn(token: String, type: ThirdPartyLoginType)
}

extension AuthAPI {
    var path: String {
        switch self {
        case let .signIn(_, loginType):
            "\(loginType.rawValue)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .signIn:
            .post
        }
    }

    var bodyParameters: [String: String]? {
        switch self {
        case let .signIn(token, _):
            return ["token": token]
        }
    }

    var needsAuthorization: Bool {
        switch self {
        case .signIn:
            false
        }
    }
}
