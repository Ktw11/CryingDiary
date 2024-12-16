//
//  SignInViewModel.swift
//  SignIn
//
//  Created by 공태웅 on 12/15/24.
//

import SwiftUI

@Observable
@MainActor
public final class SignInViewModel {
    
    // MARK: Lifecycle
    
    init(signInTypes: [SignInType]) {
        self.signInTypes = signInTypes
    }
    
    let signInTypes: [SignInType]
    
    func didTap(type: SignInType) {
        #warning("sign in 로직 적용")
    }
}
