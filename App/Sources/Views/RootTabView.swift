//
//  RootTabView.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/28/24.
//

import SwiftUI
import SharedResource
import HomeInterface
import NewPostInterface

struct RootTabView<HomeComponent: HomeBuilder, NewPostComponent: NewPostBuilder>: View {
    
    // MARK: Lifecycle
    
    init(
        homeBuilder: HomeComponent,
        newPostBuilder: NewPostComponent
    ) {
        self.homeBuilder = homeBuilder
        self.newPostBuilder = newPostBuilder
    }
    
    // MARK: Properties

    @State private var selected: TabSelection = .home
    @State private var presentingNewPost = false
    private let homeBuilder: HomeComponent
    private let newPostBuilder: NewPostComponent

    var body: some View {
        VStack(spacing: 0) {
            switch selected {
            case .home:
                homeBuilder.homeView()
            case .profile:
                VStack {
                    Spacer()
                    Text("PROFILE VIEW")
                    Spacer()
                }
            }
            
            CustomTabView(selected: $selected, presentingNewPost: $presentingNewPost)
                .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea(.bottom)
        .padding(.top, 20)
        .fullScreenCover(isPresented: $presentingNewPost) {
            newPostBuilder.newPostView(postingDate: Date())
        }
    }
}

#Preview {
    let featureComponent = DependencyContainer().featureComponent
    RootTabView(
        homeBuilder: featureComponent.homeBuilder(),
        newPostBuilder: featureComponent.newPostBuilder()
    )
}

private struct CustomTabView: View {
    
    @Binding var selected: TabSelection
    @Binding var presentingNewPost: Bool

    var body: some View {
        HStack(alignment: .center) {
            
            Color.clear
                .frame(width: 50)
    
            Button {
                selected = .home
            } label: {
                CryingDiaryAsset.Image.icCalendarTab.swiftUIImage
                    .renderingMode(.template)
                    .resizable()
                    .tint(selected == .home ? SharedResourceAsset.Color.primaryColor.swiftUIColor : Color.gray)
                    .frame(width: 27, height: 27)
            }
           
            Spacer()
            
            Button {
                presentingNewPost = true
            } label: {
                CryingDiaryAsset.Image.icAddTab.swiftUIImage
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .tint(Color.gray)
                    .frame(width: 30, height: 30)
            }
            
            Spacer()
            
            Button {
                selected = .profile
            } label: {
                CryingDiaryAsset.Image.icProfileTab.swiftUIImage
                    .renderingMode(.template)
                    .resizable()
                    .tint(selected == .profile ? SharedResourceAsset.Color.primaryColor.swiftUIColor : Color.gray)
                    .frame(width: 27, height: 27)
            }
            
            Color.clear
                .frame(width: 50)
        }
        .frame(height: 85)
    }
}
