//
//  AuthManagerKey.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

struct AuthManagerKey: EnvironmentKey {
    static let defaultValue: any AuthManagable = FirebaseAuthManager(appleLoginHelper: AppleLoginHelper())
}
