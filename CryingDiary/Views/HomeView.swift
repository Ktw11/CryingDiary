//
//  HomeView.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: Lifecycle
    
    init(userId: String, alertTitle: Binding<String?>) {
        self.userId = userId
        self._alertTitle = alertTitle
    }
    
    // MARK: Properties
    
    @Binding var alertTitle: String?
    private let userId: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text("@@@ 로그인 햇음: \(userId)")
            Button(action: {
                signOut()
            }, label: {
                Text("@@@ Logout")
                    .font(.title2)
            })
        }
    }
}

extension HomeView {
    func signOut() {
        Task {
            do {
//                try await dependency.authController.signOut()
            } catch {
                self.alertTitle = "@@@ signOut 에러 발생"
            }
        }
    }
}

#Preview {
    HomeView(userId: "User", alertTitle: .constant(nil))
}
