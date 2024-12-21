//
//  GlobalAppState.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/10/24.
//

import SwiftUI

@MainActor
@Observable
final class GlobalAppState {
    var toasts: [Toast] = []
}

protocol AppStateUpdatable: AnyObject {
    @MainActor func appendToast(_ toast: Toast)
}

extension GlobalAppState: AppStateUpdatable {
    func appendToast(_ toast: Toast) {
        toasts.append(toast)
    }
}
