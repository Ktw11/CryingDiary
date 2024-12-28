//
//  CalendarViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/22/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class CalendarViewModel {
    
    // MARK: Deifinitions
    
    enum WeekdaySymbol: CaseIterable {
        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        
        var stringValue: String {
            switch self {
             case .sunday, .saturday:
                return "S"
            case .monday:
                return "M"
            case .tuesday, .thursday:
                return "T"
            case .wednesday:
                return "W"
            case .friday:
                return "F"
            }
        }
    }
    
    struct Weekday: Hashable, Equatable {
        var title: String {
            symbol.stringValue
        }
        
        var foregroundColor: Color {
            switch symbol {
            case .sunday:
                return Color.red
            case .saturday:
                return Color.blue
            default:
                return Color.gray
            }
        }
        
        private let symbol: WeekdaySymbol
        
        init(symbol: WeekdaySymbol) {
            self.symbol = symbol
        }
    }
    
    // MARK: Lifecycle
    
    init(
        monthString: String,
        yearString: String,
        cellViewModelTypes: [DayCellViewModelType]
    ) {
        self.monthString = monthString
        self.yearString = yearString
        self.cellViewModelTypes = cellViewModelTypes
    }

    // MARK: Properties
    
    
    let monthString: String
    let yearString: String
    let cellViewModelTypes: [DayCellViewModelType]
    let weekDays: [Weekday] = WeekdaySymbol.allCases.map(Weekday.init)
}
