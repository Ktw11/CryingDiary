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
    
    @Environment(\.dismiss) var dismiss
    private let viewModel: NewPostViewModel
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    SharedResourceAsset.Image.icExit.swiftUIImage
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.trailing, 28)
                })
            }
            
            DateHeaderView(viewModel: viewModel.headerViewModel)
                .padding(.bottom, 30)
            
            GeometryReader { geometry in
                HStack {
                    Spacer()
                    
                    PostingCardView(viewModel: viewModel.cardViewModel)
                        .frame(width: geometry.size.width * 0.8)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 50)
        }
        .background(SharedResourceAsset.Color.backgroundGray.swiftUIColor)
    }
}

#Preview {
    NewPostView(viewModel: .init(postingDate: Date()))
}
