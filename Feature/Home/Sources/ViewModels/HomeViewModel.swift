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
            page: CalendarPage(
                year: Self.calendar.component(.year, from: currentDate),
                month: Self.calendar.component(.month, from: currentDate)
            ),
            monthString: Self.monthFormatter.string(from: currentDate),
            cellViewModelTypes: dayCellViewModelTypes(in: currentDate, with: diaries)
        )
    }
    
    var calendarDetailViewModel: CalendarDetailViewModel {
        CalendarDetailViewModel(
            day: Self.calendar.component(.day, from: tappedDate),
            cellViewModels: calendarDetailCellViewModels()
        )
    }
    
    private var currentDate: Date = Date()
    private var tappedDate: Date = Date()
    private var diaries: [Diary] = []
    
    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    private static let calendar: Calendar = Calendar(identifier: .gregorian)
    
    // MARK: Methods
    
    func loadDiaries(at page: CalendarPage) {
        #warning("더미 데이터")
        let newDiaries = [
            Diary(
                id: "123",
                title: "Title",
                content: "content content content",
                timestamp: 123
            ),
//            Diary(
//                title: "Title2",
//                content: "content content content",
//                year: page.year,
//                month: page.month,
//                day: 11,
//                timeStamp: 1234
//            ),
        ]
        
        self.diaries.append(contentsOf: newDiaries)
    }
    
    func changeMonth(to direction: MonthDirection) {
        let value: Int = {
            switch direction {
            case .next:
                return 1
            case .previous:
                return -1
            }
        }()
        
        if let newMonth = Self.calendar.date(byAdding: .month, value: value, to: currentDate) {
            self.currentDate = newMonth
        }
    }
    
    func didTapDay(at day: Int) {
        let dates: [Date] = dates(in: currentDate).compactMap { $0 }
        guard let theDay = dates.first(where: { Self.calendar.component(.day, from: $0) == day }) else { return }
        
        self.tappedDate = theDay
    }
}

private extension HomeViewModel {
    func dayCellViewModelTypes(in month: Date, with diaries: [Diary]) -> [DayCellViewModelType] {
        dates(in: month)
            .map { date in
                if let date {
                    let day = Self.calendar.component(.day, from: date)
                    let viewModel = DayCellViewModel(
                        day: day,
                        isTapped: tappedDate == date,
                        isToday: day == Self.calendar.component(.day, from: Date()), numberOfDiaries: diaries.count
                    )
                    return .general(viewModel)
                } else {
                    return .empty(UUID().uuidString)
                }
            }
    }
    
    func calendarDetailCellViewModels() -> [CalendarDetailCellViewModel] {
        #warning("더미 데이터")
        let newDiaries = [
            Diary(
                id: "ID",
                title: "Title",
                content: "content content content",
                timestamp: 1735447621
            ),
        ]
        
        return newDiaries.map(CalendarDetailCellViewModel.init)
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
