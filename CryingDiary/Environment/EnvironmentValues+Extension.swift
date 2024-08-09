//
//  EnvironmentValues+Extension.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

extension EnvironmentValues {
    var authManager: any AuthManagable {
        get { self[AuthManagerKey.self] }
        set { self[AuthManagerKey.self] = newValue }
    }
}
