//
//  ToastWindowWrapper.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/17/24.
//

import SwiftUI

struct ToastWindowWrapper<Content: View>: View {
    
    // MARK: Properties
    
    @Binding var toasts: [Toast]
    @ViewBuilder var content: Content
    @State private var toastWindow: UIWindow?
    
    var body: some View {
        content
            .onAppear {
                
            }
    }
}


