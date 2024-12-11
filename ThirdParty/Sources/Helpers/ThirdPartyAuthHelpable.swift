//
//  ThirdPartyAuthHelpable.swift
//  ThirdParty
//
//  Created by 공태웅 on 11/29/24.
//

import Foundation

protocol ThirdPartyAuthHelpable: Sendable {
    @MainActor func configure()
    @MainActor func handleURL(_ url: URL) -> Bool
    func getToken() async throws -> String
    func signOut() async throws
    func unlink() async throws
}
