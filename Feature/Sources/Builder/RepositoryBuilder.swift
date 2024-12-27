//
//  RepositoryBuilder.swift
//  Feature
//
//  Created by 공태웅 on 12/27/24.
//

import Foundation
import Domain

public protocol RepositoryBuilder {
    var authRepository: AuthRepository { get }
    var signInInfoRepository: SignInInfoRepository { get }
}
