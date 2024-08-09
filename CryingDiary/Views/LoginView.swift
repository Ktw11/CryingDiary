//
//  LoginView.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

struct LoginView: View {
    // MARK: Properties
    
    @State private var showProgressView: Bool = false
    @State private var alertTitle: String?
    @Environment(\.authManager) private var authManager
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    signIn(with: .apple)
                }, label: {
                    appleLoginView
                })
            }
            
            ProgressView()
                .opacity(showProgressView ? 1.0 : 0)
        }
        .alert(alertTitle ?? "@@@ default message", isPresented: Binding.constant(alertTitle != nil)) {
            Button("@@@ OK", role: .cancel) {
                alertTitle = nil
            }
        }
    }
}

private extension LoginView {
    @ViewBuilder
    var appleLoginView: some View {
        Text("@@@ Login To Apple")
            .font(.title)
    }
    
    func signIn(with type: ThirdPartyLoginType) {
        showProgressView = true
        
        Task {
            do {
                try await authManager.signIn(with: type)
            } catch {
                alertTitle = "@@@ 에러 발생"
            }
            
            showProgressView = false
        }
    }
}

#Preview {
    LoginView()
}
