//
//  Feature+Home.swift
//  Feature
//
//  Created by 공태웅 on 12/11/24.
//

import SwiftUI
import Home

public extension FeatureComponent {
    @ViewBuilder
    @MainActor
    func buildHome(userId: String) -> some View {
        HomeView(userId: userId)
    }
}
