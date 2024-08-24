//
//  AuthControllerKey.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import SwiftUI

struct AuthControllerKey: EnvironmentKey {
    static let defaultValue: any AuthControllable = FirebaseAuthController(
        appleLoginHelper: AppleLoginHelper(),
        kakaoLoginHelper: KakaoLoginHelper()
    )
}
