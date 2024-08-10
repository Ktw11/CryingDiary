//
//  AuthControllable.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation

protocol AuthControllable: Sendable {
    func signIn(with type: ThirdPartyLoginType) async throws
}
