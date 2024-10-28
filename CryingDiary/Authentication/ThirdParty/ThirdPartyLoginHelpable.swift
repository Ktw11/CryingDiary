//
//  ThirdPartyLoginHelpable.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/19/24.
//

import Foundation

protocol ThirdPartyLoginHelpable: Sendable {
    func getToken() async throws -> String
    func getSavedToken(needRequest: Bool) async -> String?
}
