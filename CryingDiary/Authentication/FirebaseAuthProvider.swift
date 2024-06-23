//
//  FirebaseAuthProvider.swift
//  CryingDiary
//
//  Created by 공태웅 on 6/23/24.
//

import Foundation
import FirebaseAuth

final actor FirebaseAuthProvider {
    // MARK: Properties
    
    // TODO: - User 정보를 담은 객체를 가지도록 수정 필요
    @Published var currentUserName: String?
    private let auth: Auth = Auth.auth()
    
    init() async {
        setUpStateListener()
    }
}

private extension FirebaseAuthProvider {
    func setUpStateListener() {
        auth.addStateDidChangeListener { auth, firebaseUser in
            Task { [weak self] in
                await self?.setUserName(to: firebaseUser?.displayName)
            }
        }
    }
    
    func setUserName(to name: String?) {
        currentUserName = name
    }
}
