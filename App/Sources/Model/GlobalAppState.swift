//
//  GlobalAppState.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation
import Domain

@Observable
@MainActor
final class GlobalAppState {
    var toasts: [Toast]
    
    init(toasts: [Toast] = []) {
        self.toasts = toasts
    }
}

extension GlobalAppState: AppStateUpdatable {
    func appendToast(_ toast: Toast) {
        toasts.append(toast)
    }
}
