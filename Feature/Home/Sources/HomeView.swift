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
        ScrollView {
            VStack {
                CalendarView(viewModel: viewModel.calendarViewModel)
                    .padding(.horizontal, 10)
                
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .padding(.vertical, 10)
                
                CalendarDetailView(viewModel: viewModel.calendarDetailViewModel)
            }
            .environment(viewModel)
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
        .padding()
}
