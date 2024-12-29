//
//  NewPostComponent.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import SwiftUI
import NewPostInterface

public final class NewPostComponent: NewPostBuilder {

    public typealias SomeView = NewPostView
    
    public init() { }
    
    @MainActor
    @ViewBuilder
    public func newPostView(postingDate: Date) -> NewPostView {
        let viewModel = NewPostViewModel(postingDate: postingDate)
        NewPostView(viewModel: viewModel)
    }
}
