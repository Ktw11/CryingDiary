//
//  CryingDiaryApp.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI
import SwiftData

@main
struct CryingDiaryApp: App {

    // MARK: Properties

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    private let dependency: DependencyContainable = DependencyContainerKey.defaultValue
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(authController: dependency.authController))
                .environment(\.dependencyContainer, dependency)
        }
    }
}
