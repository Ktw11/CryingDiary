//
//  LoginInfoRepository.swift
//  CryingDiary
//
//  Created by 공태웅 on 9/28/24.
//

import Foundation
import SwiftData

protocol LoginInfoRepositoryType: Sendable {
    func retrieve() async -> LoginInfo?
    func save(info: LoginInfo) async throws
    func reset() async throws
}

@ModelActor
final actor LoginInfoRepository: LoginInfoRepositoryType {
    
    // MARK: Lifecycle
    
    init() {
        let schema = Schema([
            PersistedLoginInfo.self,
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
    
    func retrieve() -> LoginInfo? {
        let descriptor = FetchDescriptor<PersistedLoginInfo>()
        let infos = try? modelContext.fetch(descriptor)
        return infos?
            .compactMap { info -> LoginInfo? in
                guard let convertedType = ThirdPartyLoginType(rawValue: info.loginType) else { return nil }
                return LoginInfo(refreshToken: info.refreshToken, loginType: convertedType)
            }
            .first
    }

    func save(info: LoginInfo) throws {
        try reset()
        modelContext.insert(info.toPersisted)
        try modelContext.save()
    }
    
    func reset() throws {
        try modelContext.delete(model: PersistedLoginInfo.self)
    }
}

@Model
private final class PersistedLoginInfo {
    @Attribute(.unique) var refreshToken: String
    var loginType: String
    
    init(refreshToken: String, loginType: ThirdPartyLoginType) {
        self.refreshToken = refreshToken
        self.loginType = loginType.rawValue
    }
}

private extension LoginInfo {
    var toPersisted: PersistedLoginInfo {
        PersistedLoginInfo(refreshToken: refreshToken, loginType: loginType)
    }
}
