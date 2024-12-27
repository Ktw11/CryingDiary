//
//  HomeView.swift
//  Home
//
//  Created by 공태웅 on 12/11/24.
//

import SwiftUI
import HomeInterface

public struct HomeView: View {
    
    public init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    private let viewModel: HomeViewModel
    
    public var body: some View {
        CalendarView()
    }
}

#Preview {
    HomeView(viewModel: .init())
}
