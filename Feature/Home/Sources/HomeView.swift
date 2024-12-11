//
//  HomeView.swift
//  Home
//
//  Created by 공태웅 on 12/11/24.
//

import SwiftUI

public struct HomeView: View {
    
    public init(userId: String) {
        self.userId = userId
    }
    
    private let userId: String
    
    public var body: some View {
        Text("@@@ 로그인 햇음: \(userId)")
    }
}

#Preview {
    HomeView(userId: "Dummy_ID")
}
