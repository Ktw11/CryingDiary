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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    private let authManager = FirebaseAuthManager(
        appleLoginHelper: AppleLoginHelper()
    )

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.authManager, authManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
