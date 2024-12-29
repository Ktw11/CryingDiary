//
//  NewPostViewModel.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class NewPostViewModel {
    // MARK: Lifecycle
    
    init(postingDate: Date) {
        self.postingDate = postingDate
    }

    var headerViewModel: DateHeaderViewModel {
        DateHeaderViewModel(date: postingDate)
    }
    
    var cardViewModel: PostingCardViewModel {
        PostingCardViewModel(timestamp: postingDate.timeIntervalSince1970)
    }
    
    private let postingDate: Date
}
