//
//  NewPostView.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import SwiftUI
import SharedResource

public struct NewPostView: View {
    
    // MARK: Lifecycle
    
    public init(viewModel: NewPostViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Properties
    
    private let viewModel: NewPostViewModel
    
    public var body: some View {
        VStack(spacing: 35) {
            DateHeaderView(viewModel: viewModel.headerViewModel)
            
            GeometryReader { geometry in
                HStack {
                    Spacer()
                    
                    PostingCardView(viewModel: viewModel.cardViewModel)
                        .frame(width: geometry.size.width * 0.8)
                    
                    Spacer()
                }
            }
        }
        .background(SharedResourceAsset.backgroundGray.swiftUIColor)
    }
}

#Preview {
    NewPostView(viewModel: .init(postingDate: Date()))
}
