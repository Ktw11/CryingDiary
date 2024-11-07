//
//  LoginHelperFactory.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/7/24.
//

import Foundation

protocol LoginHelperFactoryType {
    func getHelper(loginType: ThirdPartyLoginType) -> ThirdPartyLoginHelpable
}

struct LoginHelperFactory: LoginHelperFactoryType {
    func getHelper(loginType: ThirdPartyLoginType) -> ThirdPartyLoginHelpable {
        switch loginType {
        case .apple:
            AppleLoginHelper()
        case .kakao:
            KakaoLoginHelper()
        }
    }
}
