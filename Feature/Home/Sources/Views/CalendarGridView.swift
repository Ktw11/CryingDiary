//
//  CalendarGridView.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation
import SwiftUI
import SharedResource

struct CalendarGridView: View {
    
    // MARK: Lifecycle
    
    init(viewModel: CalendarGridViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Properties
    
    @Environment(HomeViewModel.self) private var homeViewModel
    private let viewModel: CalendarGridViewModel
    
    var body: some View {
        LazyVGrid(columns: viewModel.columns, spacing: viewModel.spacing) {
            ForEach(viewModel.cellViewModelTypes, id: \.self) { viewModelType in
                Button(
                    action: {
                        guard case let .general(viewModel) = viewModelType else { return }
                        homeViewModel.didTapDay(at: viewModel.day)
                    }, label: {
                        Group {
                            switch viewModelType {
                            case let .general(viewModel):
                                DayCellView(viewModel: viewModel)
                            case .empty:
                                Color.clear
                            }
                        }
                        .frame(height: 44)
                    })
            }
        }
    }
}

private struct DayCellView: View, Equatable {
    
    // MARK: Lifecycle
    
    init(viewModel: DayCellViewModel) {
        self.viewModel = viewModel
    }
    
    private let viewModel: DayCellViewModel
    
    var body: some View {
        VStack(spacing: 3) {
            Text("\(viewModel.day)")
                .font(SharedFont.bigJohnPRO(size: 13, weight: viewModel.isBold ? .bold : .regular))
                .foregroundStyle(viewModel.foregroundColor)
                .background {
                    Capsule()
                        .foregroundStyle(.red)
                        .frame(width: 31)
                        .opacity(viewModel.isTapped ? 1.0 : 0)
                }
                .frame(height: 19)
            
            VStack(spacing: 2) {
                ForEach(viewModel.stackColors, id: \.self) { color in
                    Capsule()
                        .foregroundStyle(color)
                        .frame(height: 5)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    ZStack(alignment: .center) {
        DayCellView(viewModel: .init(day: 15, isTapped: false, isToday: false, numberOfDiaries: 3))
    }
}
