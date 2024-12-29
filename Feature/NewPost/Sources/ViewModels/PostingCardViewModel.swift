//
//  PostingCardViewModel.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class PostingCardViewModel {
    
    // MARK: Lifecycle
    
    init(timestamp: TimeInterval) {
        self.dateText = Self.getDateText(timestamp)
    }
    
    // MARK: Properties
    
    let dateText: String
    var title: String = ""
    var content: String = ""
    
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
