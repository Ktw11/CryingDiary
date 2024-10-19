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
        static let baseURL = "baseURL"
    }
    
    // MARK: Properties
    
    static let kakaoAppKey: String = {
        guard let key = infoDictionary?[Key.kakaoAppKey] as? String else {
            fatalError()
        }
        return key
    }()
    
    static let baseURL: String = {
        guard let key = infoDictionary?[Key.baseURL] as? String else {
            fatalError()
        }
        return key
    }()
}

private extension AppKeys {
    static var infoDictionary: [String: Any]? {
        Bundle.main.infoDictionary
    }
}
