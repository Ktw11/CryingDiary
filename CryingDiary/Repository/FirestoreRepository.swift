//
//  FirestoreRepository.swift
//  CryingDiary
//
//  Created by 공태웅 on 8/10/24.
//

import Foundation
import FirebaseFirestore

actor FirestoreRepository {
    
    init() {
        Task { await setUpDB() }
    }
    
    private let db = Firestore.firestore()
}

extension FirestoreRepository {
    func setUpDB() {
        
    }
}
