//
//  EnvironmentValues+Extension.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

extension EnvironmentValues {
    var authController: any AuthControllable {
        get { self[AuthControllerKey.self] }
        set { self[AuthControllerKey.self] = newValue }
    }
    
    var userStore: any UserStorable {
        get { self[UserStoreKey.self] }
        set { self[UserStoreKey.self] = newValue }
    }
}
