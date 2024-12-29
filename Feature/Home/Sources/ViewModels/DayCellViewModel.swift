//
//  DayCellViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation
import SwiftUI
import SharedResource

struct DayCellViewModel: Equatable, Hashable {
    
    // MARK: Lifecycle
    
    init(
        day: Int,
        isTapped: Bool,
        isToday: Bool,
        numberOfDiaries: Int
    ) {
        self.day = day
        self.isTapped = isTapped
        self.isToday = isToday
        self.numberOfDiaries = numberOfDiaries
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
            return SharedResourceAsset.primaryColor.swiftUIColor
        } else {
            return Color.black
        }
    }
    
    var stackColors: [Color] {
        diaryStackColors()
    }
    
    private let isToday: Bool
    private let numberOfDiaries: Int
}

private extension DayCellViewModel {
    func diaryStackColors() -> [Color] {
        let colors: [Color] = [
            SharedResourceAsset.primaryColor.swiftUIColor,
            SharedResourceAsset.secondaryColor.swiftUIColor,
            SharedResourceAsset.thirdColor.swiftUIColor
        ]
        
        return (0..<3).map { index in
            index < numberOfDiaries ? colors[index] : Color.clear
        }
    }
}
