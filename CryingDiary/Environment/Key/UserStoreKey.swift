//
//  UserStoreKey.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/25/24.
//

import SwiftUI

struct UserStoreKey: EnvironmentKey {
    static let defaultValue: any UserStorable = UserStore(userRepository: UserRepository())
}
