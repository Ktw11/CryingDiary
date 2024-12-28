//
//  RootTabView.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/28/24.
//

import SwiftUI
import SharedResource
import HomeInterface

struct RootTabView<HomeComponent: HomeBuilder>: View {
    
    // MARK: Lifecycle
    
    init(homeBuilder: HomeComponent) {
        self.homeBuilder = homeBuilder
    }
    
    // MARK: Properties

    @State private var selected: TabSelection = .home
    private let homeBuilder: HomeComponent

    var body: some View {
        TabView(selection: $selected) {
            Tab(
                value: .home,
                content: { homeBuilder.homeView() },
                label: {
                    CryingDiaryAsset.Image.icCalendarTab.swiftUIImage
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            )
            
            Tab(
                value: .card,
                content: { Text("CARD VIEW") },
                label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            )
            
            Tab(
                value: .profile,
                content: { Text("PROFILE VIEW") },
                label: {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            )
        }
        .edgesIgnoringSafeArea(.bottom)
        .tint(SharedResourceAsset.primaryColor.swiftUIColor)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = .gray
        }
    }
}

#Preview {
    let featureComponent = DependencyContainer().featureComponent
    RootTabView(homeBuilder: featureComponent.homeBuilder())
}
