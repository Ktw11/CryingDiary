//
//  EnvironmentValues+Extension.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

extension EnvironmentValues {
    var dependencyContainer: DependencyContainable {
        get { self[DependencyContainerKey.self] }
        set { self[DependencyContainerKey.self] = newValue }
    }
}
