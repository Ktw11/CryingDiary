//
//  User.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/11/24.
//

import Foundation

struct User: Decodable {
    let id: String
    let loginType: String
    let refreshToken: String
}
