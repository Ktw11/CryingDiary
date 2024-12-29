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
                Group {
                    CalendarView(viewModel: viewModel.calendarViewModel)
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.all, 10)
                    
                    CalendarDetailView(viewModel: viewModel.calendarDetailViewModel)
                }
                .padding(.horizontal, 10)
            }
            .environment(viewModel)
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}
