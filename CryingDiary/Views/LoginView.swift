//
//  LoginView.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/9/24.
//

import SwiftUI

struct LoginView: View {

    // MARK: Properties
    
    let viewModel: LoginViewModelType
    @Binding var alertTitle: String?
    
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
                .opacity(viewModel.showProgressView ? 1.0 : 0)
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
        Task {
            do {
                try await viewModel.signIn(with: type)
            } catch {
                alertTitle = "@@@ 에러 발생 \(error)"
            }
        }
    }
}

#Preview {
    let dependency = DependencyContainerKey.defaultValue
    LoginView(
        viewModel: LoginViewModel(authController: dependency.authController), alertTitle: .constant(nil)
    )
}
