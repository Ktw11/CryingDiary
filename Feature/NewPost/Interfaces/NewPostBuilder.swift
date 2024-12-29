//
//  NewPostBuilder.swift
//  NewPost
//
//  Created by 공태웅 on 12/29/24.
//

import SwiftUI

public protocol NewPostBuilder {
    associatedtype SomeView: View
    
    @MainActor
    @ViewBuilder
    func newPostView(postingDate: Date) -> SomeView
}
