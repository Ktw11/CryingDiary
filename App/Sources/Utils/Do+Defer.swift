//
//  Do+Defer.swift
//  CryingDiary
//
//  Created by 공태웅 on 7/14/24.
//

import Foundation

@discardableResult
func run<T>(
    _ operation: @Sendable () async throws -> T,
    defer deferredOperation: @Sendable () async throws -> Void
) async throws -> T {
    do {
        let result = try await operation()
        try await deferredOperation()
        return result
    } catch {
        try await deferredOperation()
        throw error
    }
}

func run(
    _ operation: @Sendable () async throws -> Void,
    catch catchOperation: @Sendable (Error) -> Void,
    defer deferredOperation: @Sendable () async -> Void
) async  {
    do {
        try await operation()
        await deferredOperation()
    } catch {
        catchOperation(error)
        await deferredOperation()
    }
}
