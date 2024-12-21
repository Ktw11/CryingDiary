//
//  SignInInfoRepositoryImpl.swift
//  Repository
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation
import SwiftData
import Domain

@ModelActor
public final actor SignInInfoRepositoryImpl: SignInInfoRepository {
    
    // MARK: Lifecycle
    
    public init() {
        let schema = Schema([
            SignInInfoDTO.self,
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
    
    public func retrieve() -> SignInInfo? {
        let descriptor = FetchDescriptor<SignInInfoDTO>()
        let infos = try? modelContext.fetch(descriptor)
        return infos?
            .compactMap { info -> SignInInfo? in
                return SignInInfo(refreshToken: info.refreshToken, signInType: info.signInType)
            }
            .first
    }

    public func save(info: SignInInfo) throws {
        try reset()
        modelContext.insert(info.toDTO)
        try modelContext.save()
    }
    
    public func reset() throws {
        try modelContext.delete(model: SignInInfoDTO.self)
    }
}

private extension SignInInfo {
    var toDTO: SignInInfoDTO {
        SignInInfoDTO(refreshToken: refreshToken, signInType: signInType)
    }
}
