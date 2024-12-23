//
//  DayCellViewModel.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation

struct DayCellViewModel: Hashable, Equatable {
    let day: Int
    let isTapped: Bool
    let isToday: Bool
}
