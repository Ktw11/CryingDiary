//
//  ThirdPartyAuthProvider.swift
//  ThirdParty
//
//  Created by 공태웅 on 5/12/24.
//

import Foundation

public enum ThirdPartyAuthProvider {
    
    // MARK: Methods
    
    @MainActor
    public static func configure() {
        ThirdPartyType.allCases.map { getHelper(type: $0) }.forEach {
            $0.configure()
        }
    }
    
    @MainActor
    @discardableResult
    public static func handleURL(_ url: URL) -> Bool {
        let iterResult = ThirdPartyType.allCases.first(where: { getHelper(type: $0).handleURL(url) })
        return iterResult == nil ? false : true
    }
    
    public static func getToken(type: String) async throws -> String {
        guard let thirdPartyType = ThirdPartyType(rawValue: type) else {
            throw ThirdPartyAuthError.invalidThirdPartyType
        }
        return try await getHelper(type: thirdPartyType).getToken()
    }
    
    public static func signOut(type: ThirdPartyType) async throws {
        try await getHelper(type: type).signOut()
    }
    
    public static func unlink(type: ThirdPartyType) async throws {
        try await getHelper(type: type).unlink()
    }
}

private extension ThirdPartyAuthProvider {
    static func getHelper(type: ThirdPartyType) -> ThirdPartyAuthHelpable {
        switch type {
        case .apple:
            AppleAuthHelper()
        case .kakao:
            KakaoAuthHelper()
        }
    }
}
