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
    
    enum WeekdaySymbol: String, CaseIterable {
        case sunday = "Sun"
        case monday = "Mon"
        case tuesday = "Tue"
        case wednesday = "Wed"
        case thursday = "Thu"
        case friday = "Fri"
        case saturday = "Sat"
    }
    
    struct Weekday: Hashable, Equatable {
        let title: String
        let foregroundColor: Color
        
        init(symbol: WeekdaySymbol) {
            self.title = symbol.rawValue
            self.foregroundColor = {
                switch symbol {
                case .sunday:
                    return Color.red
                case .saturday:
                    return Color.blue
                default:
                    return Color.gray
                }
            }()
        }
    }

    // MARK: Properties
    
    var monthString: String {
        Self.monthFormatter.string(from: currentMonth)
    }
    
    var yearString: String {
        String(Self.calendar.component(.year, from: currentMonth))
    }
    
    var cellViewModels: [DayCellViewModel?] {
        dayCellViewModels(in: currentMonth)
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
        
        guard let newMonth = Self.calendar.date(byAdding: .month, value: value, to: currentMonth) else { return }
        
        self.currentMonth = newMonth
    }
}

private extension CalendarViewModel {
    func dayCellViewModels(in month: Date) -> [DayCellViewModel?] {
        dates(in: month)
            .map { date in
                guard let date else { return nil }
                let day = Self.calendar.component(.day, from: date)

                return DayCellViewModel(
                    day: day,
                    isTapped: tappedDate == date,
                    isToday: day == Self.calendar.component(.day, from: Date())
                )
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
