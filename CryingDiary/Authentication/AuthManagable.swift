//
//  AuthManagable.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/7/24.
//

import Foundation

protocol AuthManagable: Sendable {
    func signIn(with type: ThirdPartyLoginType) async throws
}
