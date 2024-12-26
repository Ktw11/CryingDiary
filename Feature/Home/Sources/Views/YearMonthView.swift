//
//  YearMonthView.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import SwiftUI
import SharedResource

struct YearMonthView: View {
    
    // MARK: Lifecycle
    
    init(
        monthString: String,
        yearString: String,
        changeMonth: @escaping (MonthDirection) -> Void
    ) {
        self.monthString = monthString
        self.yearString = yearString
        self.changeMonth = changeMonth
    }
    
    // MARK: Properties
    
    private let monthString: String
    private let yearString: String
    private let changeMonth: (MonthDirection) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Calendar, \(yearString)")
                .font(SharedFont.bigJohnPRO(size: 17, weight: .regular))
            
            HStack(alignment: .center, spacing: 7) {
                Button(
                    action: {
                        changeMonth(.previous)
                    },
                    label: {
                        ZStack {
                            HomeAsset.Image.icChevronLeft.swiftUIImage
                                .resizable()
                                .frame(width: 6, height: 12)
                                .padding(.trailing, 10)
                                .padding(.vertical, 2.5)
                        }
                    }
                )

                Text("\(monthString)")
                    .font(SharedFont.bigJohnPRO(size: 35, weight: .regular))
                
                Button(
                    action: {
                        changeMonth(.next)
                    },
                    label: {
                        ZStack {
                            HomeAsset.Image.icChevronRight.swiftUIImage
                                .resizable()
                                .frame(width: 6, height: 12)
                                .padding(.leading, 10)
                                .padding(.vertical, 2.5)
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    YearMonthView(monthString: "September", yearString: "2025") { _ in }
}
