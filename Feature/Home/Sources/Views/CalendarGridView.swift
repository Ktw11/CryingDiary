//
//  CalendarGridView.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation
import SwiftUI

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
                
                ForEach(viewModel.cellViewModels.compactMap { $0 }, id: \.self) { viewModel in
                    DayCellView(viewModel: viewModel)
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
        ZStack(alignment: .topLeading) {
            Color.gray.opacity(0.3)
            
            Text("\(viewModel.day)")
                .foregroundStyle(viewModel.isToday ? Color.blue : Color.black)
        }
    }
}
