//
//  CalendarDetailView.swift
//  Home
//
//  Created by 공태웅 on 12/28/24.
//

import SwiftUI
import SharedResource

struct CalendarDetailView: View {
    
    // MARK: Lifecycle
    
    init(viewModel: CalendarDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Properties
    
    private let viewModel: CalendarDetailViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .topLeading) {
                Text("\(viewModel.day)")
                    .font(SharedFont.bigJohnPRO(size: 15, weight: .bold))
                    .foregroundStyle(SharedResourceAsset.primaryColor.swiftUIColor)
            }
            .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(viewModel.cellViewModels, id: \.id) { viewModel in
                    CalendarDetailCellView(viewModel: viewModel)
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
        }
        .padding(.vertical)
    }
}

#Preview {
    VStack {
        Spacer()
        
        CalendarDetailView(
            viewModel: .init(
                day: 12,
                cellViewModels: [
                    CalendarDetailCellViewModel(
                        diary: .init(
                            id: "1",
                            title: "title",
                            content: "description11",
                            timestamp: Date().timeIntervalSince1970
                        )
                    ),
                    CalendarDetailCellViewModel(
                        diary: .init(
                            id: "2",
                            title: "title",
                            content: "description11",
                            timestamp: Date().timeIntervalSince1970
                        )
                    )
                ]
            )
        )
    }
}
