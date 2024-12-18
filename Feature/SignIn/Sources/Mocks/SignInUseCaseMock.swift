//
//  SignInUseCaseMock.swift
//  SignIn
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import Domain

actor SignInUseCaseMock: SignInUseCase {
    func signIn(type: String, token: String) async throws -> SignInResponse {
        try await Task.sleep(for: .seconds(2))
        return SignInResponse(
            user: .init(id: "ID", loginType: "apple", refreshToken: "TOKEN"),
            accessToken: "TOKEN2"
        )
    }
}
