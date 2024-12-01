//
//  SignInInfoRepository.swift
//  CryingDiary
//
//  Created by 공태웅 on 11/29/24.
//

import Foundation
import SwiftData

protocol SignInInfoRepositoryType: Sendable {
    func retrieve() async -> SignInInfo?
    func save(info: SignInInfo) async throws
    func reset() async throws
}

@ModelActor
final actor SignInInfoRepository: SignInInfoRepositoryType {
    
    // MARK: Lifecycle
    
    init() {
        let schema = Schema([
            PersistedSignInInfo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let modelContext = ModelContext(container)
            self.modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
            self.modelContainer = container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    // MARK: Methods
    
    func retrieve() -> SignInInfo? {
        let descriptor = FetchDescriptor<PersistedSignInInfo>()
        let infos = try? modelContext.fetch(descriptor)
        return infos?
            .compactMap { info -> SignInInfo? in
                guard let convertedType = SignInType(rawValue: info.signInType) else { return nil }
                return SignInInfo(refreshToken: info.refreshToken, signInType: convertedType)
            }
            .first
    }

    func save(info: SignInInfo) throws {
        try reset()
        modelContext.insert(info.toPersisted)
        try modelContext.save()
    }
    
    func reset() throws {
        try modelContext.delete(model: PersistedSignInInfo.self)
    }
}

@Model
private final class PersistedSignInInfo {
    @Attribute(.unique) var refreshToken: String
    var signInType: String
    
    init(refreshToken: String, signInType: SignInType) {
        self.refreshToken = refreshToken
        self.signInType = signInType.rawValue
    }
}

private extension SignInInfo {
    var toPersisted: PersistedSignInInfo {
        PersistedSignInInfo(refreshToken: refreshToken, signInType: signInType)
    }
}
