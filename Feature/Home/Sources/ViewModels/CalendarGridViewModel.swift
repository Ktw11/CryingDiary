//
//  CalendarGridViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation
import SwiftUI

@Observable
@MainActor
final class CalendarGridViewModel {
    
    // MARK: Lifecycle
    
    init(cellViewModelTypes: [DayCellViewModelType], columns: [GridItem], spacing: CGFloat) {
        self.cellViewModelTypes = cellViewModelTypes
        self.columns = columns
        self.spacing = spacing
    }
    
    // MARK: Properties
    
    let cellViewModelTypes: [DayCellViewModelType]
    let columns: [GridItem]
    let spacing: CGFloat
    
    // MARK: Methods
    
    func cellWidth(totalWidth: CGFloat) -> CGFloat {
        let numberOfColumns: Int = columns.count
        let widthWithoutSpacing: CGFloat = totalWidth - (spacing * CGFloat(numberOfColumns - 1))
        return widthWithoutSpacing / CGFloat(numberOfColumns)
    }
}