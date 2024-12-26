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

    // MARK: Properties
    
    var monthString: String {
        Self.monthFormatter.string(from: currentMonth)
    }
    
    var yearString: String {
        String(Self.calendar.component(.year, from: currentMonth))
    }
    
    var cellViewModelTypes: [DayCellViewModelType] {
        dayCellViewModelTypes(in: currentMonth)
    }
    
    let weekDays: [Weekday] = WeekdaySymbol.allCases.map(Weekday.init)
    
    private var currentMonth: Date = Date()
    private var tappedDate: Date?
    
    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    private static let calendar: Calendar = Calendar(identifier: .gregorian)
    
    // MARK: Methods
    
    func changeMonth(to direction: MonthDirection) {
        let value: Int = {
            switch direction {
            case .next:
                return 1
            case .previous:
                return -1
            }
        }()
        
        if let newMonth = Self.calendar.date(byAdding: .month, value: value, to: currentMonth) {
            self.currentMonth = newMonth
        }
    }
}

private extension CalendarViewModel {
    func dayCellViewModelTypes(in month: Date) -> [DayCellViewModelType] {
        dates(in: month)
            .map { date in
                if let date {
                    let day = Self.calendar.component(.day, from: date)
                    let viewModel = DayCellViewModel(
                        day: day,
                        isTapped: tappedDate == date,
                        isToday: day == Self.calendar.component(.day, from: Date())
                    )
                    return .general(viewModel)
                } else {
                    return .empty(UUID().uuidString)
                }
            }
    }
    
    func dates(in month: Date) -> [Date?] {
        guard let range = Self.calendar.range(of: .day, in: .month, for: month) else { return [] }
        let dateComponents = Self.calendar.dateComponents([.year, .month], from: month)
        guard let firstDay = Self.calendar.date(from: dateComponents) else { return [] }
        
        let weekday = Self.calendar.component(.weekday, from: firstDay) - 1
        
        var dates: [Date?] = Array(repeating: nil, count: weekday)
        for day in 1...range.count {
            if let date = Self.calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                dates.append(date)
            }
        }
        
        return dates
    }
}
