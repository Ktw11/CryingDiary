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
    
    init(id: String, image: Image?, dateText: String, title: String) {
        self.id = id
        self.image = image
        self.dateText = dateText
        self.title = title
    }
    
    // MARK: Properties
    
    let id: String
    let image: Image?
    let dateText: String
    let title: String
}
