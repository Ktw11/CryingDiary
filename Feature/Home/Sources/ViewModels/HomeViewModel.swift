//
//  HomeViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI

@Observable
@MainActor
public final class HomeViewModel {
    
    // MARK: Lifecycle
    
    public init() {
        
    }
    
    // MARK: Properties

    var calendarViewModel: CalendarViewModel {
        CalendarViewModel(
            monthString: Self.monthFormatter.string(from: currentMonth),
            yearString: String(Self.calendar.component(.year, from: currentMonth)),
            cellViewModelTypes: dayCellViewModelTypes(in: currentMonth)
        )
    }
    
    var calendarDetailViewModel: CalendarDetailViewModel {
        CalendarDetailViewModel(
            day: Self.calendar.component(.day, from: tappedDate),
            cellViewModels: calendarDetailCellViewModels()
        )
    }
    
    private var currentMonth: Date = Date()
    private var tappedDate: Date = Date()
    
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
    
    func didTapDay(at day: Int) {
        let dates: [Date] = dates(in: currentMonth).compactMap { $0 }
        guard let theDay = dates.first(where: { Self.calendar.component(.day, from: $0) == day }) else { return }
        
        self.tappedDate = theDay
    }
}

private extension HomeViewModel {
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
    
    func calendarDetailCellViewModels() -> [CalendarDetailCellViewModel] {
        #warning("TODO: make calendarDetailCellViewModels")
        return []
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
