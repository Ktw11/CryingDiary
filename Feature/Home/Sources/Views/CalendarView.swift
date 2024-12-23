//
//  CalendarView.swift
//  Home
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation
import SwiftUI

struct CalendarView: View {

    // MARK: Definitions
    
    private enum Constants {
        static let gridSpacing: CGFloat = 10
    }
    
    // MARK: Properties
    
    @State private var viewModel: CalendarViewModel = .init()
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                YearMonthView(monthString: viewModel.monthString, yearString: viewModel.yearString) { direction in
                    viewModel.changeMonth(to: direction)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 25)
            
            LazyVGrid(columns: columns, spacing: Constants.gridSpacing) {
                ForEach(viewModel.weekDays, id: \.self) { weekday in
                    Text(weekday.title)
                        .foregroundStyle(weekday.foregroundColor)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)

            CalendarGridView(
                viewModel: .init(
                    cellViewModelTypes: viewModel.cellViewModelTypes,
                    columns: columns,
                    spacing: Constants.gridSpacing
                )
            )
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}

#Preview {
   ZStack {
        CalendarView()
            .padding()
    }
}
