//
//  DayCellViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation
import SwiftUI

struct DayCellViewModel: Equatable, Hashable {
    
    // MARK: Lifecycle
    
    init(
        day: Int,
        isTapped: Bool,
        isToday: Bool
    ) {
        self.day = day
        self.isTapped = isTapped
        self.isToday = isToday
    }
    
    // MARK: Properties
    
    let day: Int
    let isTapped: Bool
    
    var isBold: Bool {
        isToday || isTapped
    }
    
    var foregroundColor: Color {
        guard !isTapped else { return Color.white }
        
        if isToday {
            return HomeAsset.Color.accentColor.swiftUIColor
        } else {
            return Color.black
        }
    }
    
    private let isToday: Bool
}
