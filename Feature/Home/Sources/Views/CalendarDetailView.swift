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
            Text("\(viewModel.day)")
                .font(SharedFont.bigJohnPRO(size: 15, weight: .bold))
                .foregroundStyle(SharedResourceAsset.primaryColor.swiftUIColor)
            
            Spacer()
                .frame(maxWidth: 40)
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(viewModel.cellViewModels, id: \.id) { viewModel in
                    CalendarDetailCellView(viewModel: viewModel)
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
        }
        .padding()
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
                        id: "1",
                        image: nil,
                        dateText: "2025.1.12 11:30am",
                        title: "오늘의 소소한 Flex"
                    ),
                    CalendarDetailCellViewModel(
                        id: "2",
                        image: nil,
                        dateText: "2025.1.12 11:30am",
                        title: "오늘의 소소한 Fldjfjsljklsfjlsex"
                    )
                ]
            )
        )
    }
}
