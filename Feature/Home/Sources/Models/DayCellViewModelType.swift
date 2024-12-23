//
//  DayCellViewModelType.swift
//  Home
//
//  Created by 공태웅 on 12/23/24.
//

import Foundation

enum DayCellViewModelType: Equatable, Hashable {
    case empty(String)
    case general(DayCellViewModel)
}
