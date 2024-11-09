//
//  HomeView.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: Lifecycle
    
    init(
        userId: String,
        alertTitle: Binding<String?>,
        tapLogoutButton: @escaping () -> Void,
        tapUnlinkButton: @escaping () -> Void
    ) {
        self.userId = userId
        self._alertTitle = alertTitle
        self.tapLogoutButton = tapLogoutButton
        self.tapUnlinkButton = tapUnlinkButton
    }
    
    // MARK: Properties
    
    var tapLogoutButton: () -> Void
    var tapUnlinkButton: () -> Void
    private let userId: String
    @Binding var alertTitle: String?
    
    var body: some View {
        VStack(spacing: 15) {
            Text("@@@ 로그인 햇음: \(userId)")
            Button(action: {
                tapLogoutButton()
            }, label: {
                Text("@@@ Logout")
                    .font(.title2)
            })
            Spacer()
            Button(action: {
                tapUnlinkButton()
            }, label: {
                Text("@@@ Unlink")
                    .font(.title2)
            })
        }
    }
}

#Preview {
    HomeView(userId: "User", alertTitle: .constant(nil), tapLogoutButton: {}, tapUnlinkButton: {})
}
