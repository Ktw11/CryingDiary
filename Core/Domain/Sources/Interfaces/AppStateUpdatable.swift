//
//  AppStateUpdatable.swift
//  Domain
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation

public protocol AppStateUpdatable: Observable, Sendable {
    @MainActor func appendToast(_ toast: Toast)
}
