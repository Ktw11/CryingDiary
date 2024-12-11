//
//  AuthServiceError.swift
//  Service
//
//  Created by 공태웅 on 11/29/24.
//

import Foundation

enum AuthServiceError: Error {
    case invalidSignInType
    case signInInfoNotFound
}
