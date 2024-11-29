//
//  API+Extension.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/24/24.
//

import Foundation
import Network

extension API {
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
    var queryParameters: [String: String]? { nil }
    var bodyParameters: [String: String]? { nil }
    var needsAuthorization: Bool { true }
}
