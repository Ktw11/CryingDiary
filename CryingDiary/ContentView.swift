//
//  ContentView.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // MARK: Properties
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State private var alertTitle: String?
    @State private var authController = FirebaseAuthController(
        appleLoginHelper: AppleLoginHelper()
    )
    @State private var userStore: UserStorable = UserStore(userRepository: UserRepository())

    var body: some View {
        ZStack {
            if let user = userStore.user {
                HomeView(userId: user.id, alertTitle: $alertTitle)
            } else {
                LoginView(alertTitle: $alertTitle)
            }
        }
        .alert(alertTitle ?? "@@@ default message", isPresented: Binding.constant(alertTitle != nil)) {
            Button("@@@ OK", role: .cancel) {
                alertTitle = nil
            }
        }
        .environment(\.authController, authController)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
