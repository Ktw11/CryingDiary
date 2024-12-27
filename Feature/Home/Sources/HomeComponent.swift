//
//  HomeComponent.swift
//  Home
//
//  Created by 공태웅 on 12/27/24.
//

import SwiftUI
import HomeInterface

public final class HomeComponent: HomeBuilder {
    public typealias SomeView = HomeView
    
    public init() {
        
    }
    
    @MainActor
    @ViewBuilder
    public func homeView() -> SomeView {
        HomeView(viewModel: .init())
    }
}
