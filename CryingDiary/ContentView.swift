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

    @State private var loginStateStore: LoginStateStorable = LoginStateStore()

    var body: some View {
        ZStack {
            if let id = loginStateStore.currentUserId {
                Text("@@@ 로그인 햇음: \(id)")
            } else {
                LoginView()
            }
        }
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
