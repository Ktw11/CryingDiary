//
//  UserRepository.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation
@preconcurrency import FirebaseFirestore

protocol UserRepositoryType: Sendable {
    func retreiveUser(id: String, loginType: ThirdPartyLoginType) async throws -> User
}

final actor UserRepository: UserRepositoryType {

    // MARK: Definitions
    
    private enum CollectionKey {
        static let users: String = "users"
    }

    private enum FieldKey {
        static let id: String = "id"
        static let loginType: String = "login_type"
    }
    
    // MARK: Properties
    
    private let db = Firestore.firestore()
    
    // MARK: Methods

    func retreiveUser(id: String, loginType: ThirdPartyLoginType) async throws -> User {
        let userRefernce = db.collection(CollectionKey.users)
            .document(id)
        
        let snapshot = try await userRefernce
            .getDocument()

        if snapshot.exists {
            return try getUser(from: snapshot)
        } else {
            return try await storeUser(id: id, loginType: loginType, at: userRefernce)
        }
    }
}

private extension UserRepository {
    func getUser(from snapshot: DocumentSnapshot) throws -> User {
        guard let data = snapshot.data() else { throw RepositoryError.userNotFound }
        guard let user = convertToUser(data: data) else { throw RepositoryError.invalidData }
        return user
    }
    
    func convertToUser(data dictionary: [String: Any]) -> User? {
        guard let id = dictionary[FieldKey.id] as? String,
              let loginTypeString = dictionary[FieldKey.loginType] as? String,
              let loginType = ThirdPartyLoginType(rawValue: loginTypeString) else {
            return nil
        }
        
        return User(id: id, loginType: loginType)
    }
    
    func storeUser(
        id: String,
        loginType: ThirdPartyLoginType,
        at reference: DocumentReference
    ) async throws -> User {
        let userData: [String: Any] = [
            FieldKey.id: id,
            FieldKey.loginType: loginType.rawValue
        ]
        try await reference.setData(userData)
        
        return User(id: id, loginType: loginType)
    }
}
