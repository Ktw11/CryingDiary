//
//  Toast.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/9/24.
//

import Foundation

struct Toast: Identifiable, Equatable {
    private(set) var id: String = UUID().uuidString
    let message: String
    let duration: Duration = .seconds(2)
}
