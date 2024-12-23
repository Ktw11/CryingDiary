//
//  YearMonthView.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import SwiftUI

struct YearMonthView: View {
    
    // MARK: Lifecycle
    
    init(monthString: String, yearString: String) {
        self.monthString = monthString
        self.yearString = yearString
    }
    
    // MARK: Properties
    
    private let monthString: String
    private let yearString: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button(
                action: {
    //                changeMonth(by: -1)
                },
                label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 12, height: 25)
                }
            )
    //        .disabled(!canMoveToPreviousMonth())
            
            VStack(alignment: .leading, spacing: 3) {
                Text(monthString)
                    .font(.title.bold())
                
                Text("diary | \(yearString)")
            }
            
            Button(
                action: {
//                    changeMonth(by: 1)
                },
                label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 12, height: 25)
                }
            )
//            .disabled(!canMoveToNextMonth())
        }
    }
}

#Preview {
    YearMonthView(monthString: "September", yearString: "2025")
}
