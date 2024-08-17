//
//  UserStore.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation
@preconcurrency import FirebaseAuth

protocol UserStorable: Sendable {
    @MainActor var user: User? { get }
}

@Observable
final class UserStore: UserStorable {
    
    // MARK: Lifecycle
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository

        setUpListener()
    }
    
    // MARK: Properties

    @MainActor private(set) var user: User?
    private let userRepository: UserRepositoryType
    private let auth: Auth = Auth.auth()
}

private extension UserStore {
    func setUpListener() {
        auth.addStateDidChangeListener { [weak self] _, firebaseUser in
            self?.setCurrentUser(to: firebaseUser?.uid)
        }
    }
    
    func setCurrentUser(to firebaseUserId: String?) {
        Task { @MainActor in
            guard let firebaseUserId else {
                self.user = nil
                return
            }
            
            self.user = try? await self.userRepository.retreiveUser(id: firebaseUserId)
        }
    }
}
