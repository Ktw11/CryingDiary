//
//  DateHeaderView.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import SwiftUI
import SharedResource

struct DateHeaderView: View {
    
    // MARK: Lifecycle
    
    init(viewModel: DateHeaderViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Properties

    private let viewModel: DateHeaderViewModel
    
    var body: some View {
        VStack(spacing: 4) {
            Text(viewModel.monthString)
            Text(viewModel.dayString)
            Text(viewModel.dayOfTheWeek)
        }
        .font(SharedFont.bigJohnPRO(size: 28, weight: .regular))
    }
}
