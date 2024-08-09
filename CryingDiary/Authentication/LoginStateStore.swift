//
//  LoginStateStore.swift
//  CryingDiary
//
//  Created by 공태웅 on 6/23/24.
//

import Foundation
import FirebaseAuth

protocol LoginStateStorable {
    var currentUserId: String? { get }
}

@Observable
final class LoginStateStore: LoginStateStorable {
    
    // MARK: Lifecycle
    
    init() {
        setUpStateListener()
    }
    
    // MARK: Properties
    
    // TODO: - User 정보를 담은 객체를 가지도록 수정 필요
    private(set) var currentUserId: String?
    
    // TODO: - Auth 객체 주입해주기
    private let auth: Auth = Auth.auth()
}

private extension LoginStateStore {
    func setUpStateListener() {
        auth.addStateDidChangeListener { [weak self] auth, firebaseUser in
            self?.currentUserId = firebaseUser?.tenantID
        }
    }
}
