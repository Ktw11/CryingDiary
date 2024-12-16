//
//  SignInUseCaseMock.swift
//  SignIn
//
//  Created by 공태웅 on 12/16/24.
//

import Foundation
import UseCase

actor SignInUseCaseMock: SignInUseCase {
    func signIn(with type: SignInType) async throws {
        try await Task.sleep(for: .seconds(2))
    }
}
