//
//  RefreshAPI.swift
//  Network
//
//  Created by 공태웅 on 9/29/24.
//

import Foundation

struct RefreshAPI: API {
    let refreshToken: String
}

extension RefreshAPI {
    var path: String {
        "refresh_token"
    }
    
    var method: HttpMethod {
        .post
    }

    var bodyParameters: [String: String]? {
        ["refreshToken": refreshToken]
    }

    var needsAuthorization: Bool {
        true
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryParameters: [String : String]? {
        nil
    }
}
