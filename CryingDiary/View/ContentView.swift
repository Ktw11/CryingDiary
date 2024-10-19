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
    @Environment(\.dependencyContainer) private var dependency

    var body: some View {
        ZStack {
            switch viewModel.scene {
            case .home(let user):
                HomeView(userId: user.id, alertTitle: $alertTitle)
            case .login:
                LoginView(viewModel: LoginViewModel(authController: dependency.authController), alertTitle: $alertTitle)
            case .splash:
                Text("@@@ SPLASH")
                    .font(.largeTitle)
            }
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
    let dependency = DependencyContainerKey.defaultValue
    ContentView(
        viewModel: ContentViewModel(
            authController: dependency.authController
        )
    )
}
