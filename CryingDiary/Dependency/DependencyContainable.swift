//
//  DependencyContainable.swift
//  CryingDiary
//
//  Created by 공태웅 on 10/24/24.
//

import SwiftUI

protocol DependencyContainable {
    @MainActor func makeContentViewModel() -> ContentViewModelType
}
