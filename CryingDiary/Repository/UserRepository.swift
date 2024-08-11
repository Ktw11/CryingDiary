//
//  UserRepository.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation
@preconcurrency import FirebaseFirestore

protocol UserRepositoryType: Sendable {
    func getUser(id: String) async throws -> User
    func getUser(signInInfo: UserSignInInfo) async throws -> User
}

final actor UserRepository: UserRepositoryType {

    // MARK: Definitions
    
    private enum CollectionKey {
        static let users: String = "users"
    }

    private enum FieldKey {
        static let id: String = "id"
        static let name: String = "name"
    }
    
    // MARK: Properties
    
    private let db = Firestore.firestore()
    
    // MARK: Methods
    
    func getUser(id: String) async throws -> User {
        try await self.getUser(id: id, signInInfo: nil)
    }
    
    func getUser(signInInfo: UserSignInInfo) async throws -> User {
        try await self.getUser(id: signInInfo.id, signInInfo: signInInfo)
    }
}

private extension UserRepository {
    func getUser(id: String, signInInfo: UserSignInInfo?) async throws -> User {
        let snapshot = try await db.collection(CollectionKey.users)
            .document(id)
            .getDocument()
        
        if let data = snapshot.data() {
            guard let name = data[FieldKey.id] as? String,
                  let id = data[FieldKey.name] as? String else {
                throw RepositoryError.invalidData
            }
            return User(id: id, name: name)
        } else {
            guard let signInInfo else { throw RepositoryError.userNotFound }
            return try await registerUser(signInInfo: signInInfo)
        }
    }
    
    func registerUser(signInInfo: UserSignInInfo) async throws -> User {
        try await db.collection(CollectionKey.users)
            .document(signInInfo.id)
            .setData([
                FieldKey.id: signInInfo.id,
                FieldKey.name: signInInfo.name
            ])
        
        return User(
            id: signInInfo.id,
            name: signInInfo.name
        )
    }
}
