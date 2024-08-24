//
//  LoginView.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

struct LoginView: View {
    // MARK: Properties
    
    @Binding var alertTitle: String?
    @State private var showProgressView: Bool = false
    @Environment(\.authController) private var authController
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Button(action: {
                    signIn(with: .apple)
                }, label: {
                    appleLoginView
                })
                
                Button(action: {
                    signIn(with: .kakao)
                }, label: {
                    kakaoLoginView
                })
            }
            
            ProgressView()
                .opacity(showProgressView ? 1.0 : 0)
        }
    }
}

private extension LoginView {
    @ViewBuilder
    var appleLoginView: some View {
        Text("@@@ Login To Apple")
            .font(.title)
    }
    
    @ViewBuilder
    var kakaoLoginView: some View {
        Text("@@@ Login To Kakao")
            .font(.title)
    }
    
    func signIn(with type: ThirdPartyLoginType) {
        showProgressView = true
        
        Task {
            do {
                try await authController.signIn(with: type)
            } catch {
                alertTitle = "@@@ 에러 발생 \(error)"
            }
            
            showProgressView = false
        }
    }
}

#Preview {
    LoginView(alertTitle: .constant(nil))
}
