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
                return LoginInfo(thirdPatryToken: info.thirdPatryToken, loginType: convertedType)
            }
            .first
    }

    func save(info: LoginInfo) throws {
        modelContext.insert(info.toPersisted)
        try modelContext.save()
    }
    
    func reset() throws {
        try modelContext.delete(model: PersistedLoginInfo.self)
    }
}

@Model
private final class PersistedLoginInfo {
    @Attribute(.unique) var thirdPatryToken: String
    var loginType: String
    
    init(thirdPatryToken: String, loginType: ThirdPartyLoginType) {
        self.thirdPatryToken = thirdPatryToken
        self.loginType = loginType.rawValue
    }
}

private extension LoginInfo {
    var toPersisted: PersistedLoginInfo {
        PersistedLoginInfo(thirdPatryToken: thirdPatryToken, loginType: loginType)
    }
}
