//
//  AuthManagable.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/7/24.
//

import Foundation

protocol AuthManagable {
    func signIn(
        token: String,
        nonce: String?,
        fullName: PersonNameComponents?
    ) async throws -> String?
}
