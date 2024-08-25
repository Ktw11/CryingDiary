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
    
    @MainActor func setLoginType(to type: ThirdPartyLoginType?)
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
    @MainActor private var loginType: ThirdPartyLoginType?
    private let userRepository: UserRepositoryType
    private let auth: Auth = Auth.auth()
    
    // MARK: Methods
    
    @MainActor
    func setLoginType(to type: ThirdPartyLoginType?) {
        self.loginType = type
    }
}

private extension UserStore {
    func setUpListener() {
        auth.addStateDidChangeListener { [weak self] _, firebaseUser in
            self?.setCurrentUser(to: firebaseUser?.uid)
        }
    }
    
    func setCurrentUser(to firebaseUserId: String?) {
        Task { @MainActor in
            guard let firebaseUserId, let loginType = loginType else {
                self.user = nil
                return
            }
            
            self.user = try? await self.userRepository.retreiveUser(id: firebaseUserId, loginType: loginType)
        }
    }
}
