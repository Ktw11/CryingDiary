//
//  Item.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
