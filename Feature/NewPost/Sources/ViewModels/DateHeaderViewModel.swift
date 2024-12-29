//
//  DateHeaderViewModel.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class DateHeaderViewModel {
    
    // MARK: Lifecycle
    
    init(date: Date) {
        self.date = date
    }
    
    // MARK: Properties
    
    var monthString: String {
        Self.monthFormatter.string(from: date) + ","
    }
    
    var dayString: String {
        let day: Int = Self.calendar.component(.day, from: date)
        let dayAsNSNumber: NSNumber = day as NSNumber
        return Self.ordinalFormatter.string(from: dayAsNSNumber) ?? String(day)
    }
    
    var dayOfTheWeek: String {
        Self.dayOfWeekFormatter.string(from: date)
    }
    
    private let date: Date
    
    private static let calendar: Calendar = Calendar(identifier: .gregorian)
    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    private static let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    private static let ordinalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
}
