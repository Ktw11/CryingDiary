//
//  CalendarDetailViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/28/24.
//

import SwiftUI

@MainActor
@Observable
final class CalendarDetailViewModel {
    
    // MARK: Lifecycle
    
    init(day: Int, cellViewModels: [CalendarDetailCellViewModel]) {
        self.day = day
        self.cellViewModels = cellViewModels
    }
    
    // MARK: Properties
    
    let day: Int
    let cellViewModels: [CalendarDetailCellViewModel]
}
