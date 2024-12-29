//
//  PostingCardView.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import SwiftUI
import SharedResource

struct PostingCardView: View {
    
    // MARK: Lifecycle
    
    init(viewModel: PostingCardViewModel) {
        self.viewModel = viewModel
        
        UITextView.appearance().textContainerInset = .zero
    }
    
    // MARK: Properties
    
    @Bindable private var viewModel: PostingCardViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(SharedResourceAsset.Color.placeholderColor.swiftUIColor)
                    .frame(height: geometry.size.height * 0.5)
                    .padding(10)
                
                Group {
                    Text(viewModel.dateText)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(SharedResourceAsset.Color.primaryColor.swiftUIColor)
                    
                    TextField("제목을 입력하세요", text: $viewModel.title)
                        .font(.system(size: 25))

                    TextEditor(text: $viewModel.content)
                        .font(.system(size: 15))
                        .contentMargins(.all, 0)
                        .overlay(alignment: .topLeading) {
                            Text("오늘의 기록 남기기")
                                .foregroundStyle(viewModel.content.isEmpty ? .gray : .clear)
                                .font(.system(size: 15))
                                .padding(.leading, 5)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                
                
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 2, y: 2)
            )
        }
    }
}
