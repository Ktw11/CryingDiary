//
//  SignInInfoRepository.swift
//  Repository
//
//  Created by 공태웅 on 12/21/24.
//

import Foundation

public protocol SignInInfoRepository: Sendable {
    func retrieve() async -> SignInInfo?
    func save(info: SignInInfo) async throws
    func reset() async throws
}
