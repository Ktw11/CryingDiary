//
//  NetworkError.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/27/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case unacceptableStatusCode
    case failedInGeneral(Error)
    case AuthenticationFailed
}
