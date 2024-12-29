//
//  CalendarDetailCellViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/28/24.
//

import SwiftUI

@Observable
@MainActor
final class CalendarDetailCellViewModel {
    
    // MARK: Lifecycle
    
    init(diary: Diary) {
        self.id = diary.id
        #warning("이미지 반영 필요")
        self.image = nil
        self.dateText = Self.getDateText(diary.timestamp)
        self.title = diary.title
    }
    
    // MARK: Properties
    
    let id: String
    let image: Image?
    let dateText: String
    let title: String
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-dd h:m a"
        return formatter
    }()
    
    // MARK: Methods
    
    private static func getDateText(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
