//
//  HomeBuilder.swift
//  HomeInterfaces
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI

public protocol HomeBuilder {
    associatedtype SomeView: View
    
    @MainActor
    @ViewBuilder
    func homeView() -> SomeView
}
