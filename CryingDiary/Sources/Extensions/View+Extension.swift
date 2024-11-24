//
//  View+Extension.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/9/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyToast(_ toasts: Binding<[Toast]>) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                ToastsView(toasts: toasts)
            }
    }
}
