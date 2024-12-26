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
    
    private let viewModel: CalendarGridViewModel
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: viewModel.columns, spacing: viewModel.spacing) {
                let cellWidth = viewModel.cellWidth(totalWidth: geometry.size.width)
                
                ForEach(viewModel.cellViewModelTypes, id: \.self) { viewModelType in
                    Group {
                        switch viewModelType {
                        case let .general(viewModel):
                            DayCellView(viewModel: viewModel)
                        case .empty:
                            Color.clear
                        }
                    }
                    .frame(height: cellWidth * (66 / 45))
                }
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
        VStack(spacing: 5) {
            Text("\(viewModel.day)")
                .font(SharedFont.bigJohnPRO(size: 13, weight: viewModel.isBold ? .bold : .regular))
                .foregroundStyle(viewModel.foregroundColor)
                .background {
                    Capsule()
                        .foregroundStyle(.red)
                        .frame(width: 31, height: 19)
                        .opacity(viewModel.isTapped ? 1.0 : 0)
                }
            
            EmptyView()
                .frame(height: 35)
        }
    }
}

#Preview {
    DayCellView(viewModel: .init(day: 15, isTapped: false, isToday: false))
}
