//
//  ContentView.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI
import Feature

struct ContentView: View {
    
    // MARK: Properties

    var viewModel: ContentViewModelType
    @Environment(GlobalAppState.self) var appState
    @State private var component: FeatureComponent = FeatureComponent()

    var body: some View {
        ZStack {
            switch appState.scene {
            case .home(let user):
                component.buildHome(userId: user.id)
            case .login:
                Text("")
            case .splash:
                Text("@@@ SPLASH")
                    .font(.largeTitle)
            }
            
            ProgressView()
                .opacity(viewModel.showProgressView ? 1.0 : 0)
        }
        .onAppear {
            viewModel.setAppStateUpdatable(appState)
            viewModel.signInWithSavedToken()
        }
    }
}

//#Preview {
//    let dependency = DependencyContainer.previewDefault
//    ContentView(
//        viewModel: dependency.makeContentViewModel()
//    )
//}
