//
//  SignInResponse.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/29/24.
//

import Foundation

struct SignInResponse: Decodable {
    let user: User
    let accessToken: String
}
