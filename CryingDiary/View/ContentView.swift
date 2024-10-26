//
//  ContentView.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    
    let viewModel: ContentViewModelType
    @State private var alertTitle: String?

    var body: some View {
        ZStack {
            switch viewModel.scene {
            case .home(let user):
                HomeView(userId: user.id, alertTitle: $alertTitle)
            case .login:
                LoginView { loginType in
                    viewModel.signIn(with: loginType)
                }
            case .splash:
                Text("@@@ SPLASH")
                    .font(.largeTitle)
            }
            
            ProgressView()
                .opacity(viewModel.showProgressView ? 1.0 : 0)
        }
        .alert(alertTitle ?? "@@@ default message", isPresented: Binding.constant(alertTitle != nil)) {
            Button("@@@ OK", role: .cancel) {
                alertTitle = nil
            }
        }
        .onAppear {
            viewModel.signInWithSavedToken()
        }
    }
}

#Preview {
    let dependency = DependencyContainer.default
    ContentView(
        viewModel: ContentViewModel(
            authController: dependency.authController,
            tokenStore: dependency.tokenStore
        )
    )
}
