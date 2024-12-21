//
//  MainTabView.swift
//  CryingDiary
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case tmp1
        case tmp2
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Group {
                    Color.red
                        .tag(Tab.home)
                    
                    Color.blue
                        .tag(Tab.tmp1)
                    
                    Color.yellow
                        .tag(Tab.tmp2)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            
            VStack {
                Spacer()
                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

private struct TabBarView: View {

    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                selectedTab = .home
            } label: {
                VStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 22)
                    if selectedTab == .home {
                        Text(verbatim: "Home")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selectedTab == .home ? Color.accentColor : Color.primary)
            
            Spacer()
            
            Button {
                selectedTab = .tmp1
            } label: {
                VStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 22)
                    if selectedTab == .tmp1 {
                        Text(verbatim: "BB")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selectedTab == .tmp1 ? Color.accentColor : Color.primary)
            
            Spacer()
            
            Button {
                selectedTab = .tmp2
            } label: {
                VStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 22)
                    if selectedTab == .tmp2 {
                        Text(verbatim: "CC")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selectedTab == .tmp2 ? Color.accentColor : Color.primary)
            
            Spacer()
        }
        .padding()
        .frame(height: 72)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainTabView()
}
