//
//  UserStore.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation
@preconcurrency import FirebaseAuth

protocol UserStorable: Sendable {
    @MainActor var currentUserId: String? { get }
}

@Observable
final class UserStore: UserStorable {
    
    // MARK: Lifecycle
    
    init() {
        setUpListener()
    }
    
    // MARK: Properties
    
    // TODO: - User 정보를 담은 객체를 가지도록 수정 필요
    @MainActor private(set) var currentUserId: String?
    private let auth: Auth = Auth.auth()
}

private extension UserStore {
    func setUpListener() {
        auth.addStateDidChangeListener { [weak self] _, firebaseUser in
            self?.setCurrentUser(to: firebaseUser?.uid)
        }
    }
    
    func setCurrentUser(to id: String?) {
        Task { @MainActor [weak self] in
            self?.currentUserId = id
        }
    }
}
