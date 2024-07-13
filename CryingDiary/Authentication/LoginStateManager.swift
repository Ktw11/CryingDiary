//
//  LoginStateManager.swift
//  CryingDiary
//
//  Created by 공태웅 on 6/23/24.
//

import Foundation
import FirebaseAuth

@Observable
final class LoginStateManager: LoginStateManagable {
    
    // MARK: Lifecycle
    
    init() {
        setUpStateListener()
    }
    
    // MARK: Properties
    
    // TODO: - User 정보를 담은 객체를 가지도록 수정 필요
    private(set) var currentUserName: String?
    
    // TODO: - Auth 객체 주입해주기
    private let auth: Auth = Auth.auth()
}

private extension LoginStateManager {
    func setUpStateListener() {
        auth.addStateDidChangeListener { [weak self] auth, firebaseUser in
            self?.setUserName(to: firebaseUser?.displayName)
        }
    }
    
    // TODO: - setUserName 방식 변경 필요
    func setUserName(to name: String?) {
//        Task { @MainActor [weak self] in
//            self?.currentUserName = name
//        }
    }
}
