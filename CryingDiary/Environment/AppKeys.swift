//
//  AppKeys.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/18/24.
//

import Foundation

enum AppKeys {
    // MARK: Definitions
    
    private enum Key {
        static let kakaoAppKey = "KakaoAppKey"
    }
    
    // MARK: Properties
    
    @MainActor
    static let kakaoAppKey: String = {
        guard let key = infoDictionary[Key.kakaoAppKey] as? String else {
            fatalError()
        }
        return key
    }()

}

private extension AppKeys {
    @MainActor
    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError()
        }
        return dictionary
    }()
}
