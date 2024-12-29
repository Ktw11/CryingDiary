//
//  FeatureComponent+NewPost.swift
//  Feature
//
//  Created by 공태웅 on 12/29/24.
//

import SwiftUI
import NewPost
import NewPostInterface

extension FeatureComponent {
    public func newPostBuilder() -> some NewPostBuilder {
        NewPostComponent()
    }
}
