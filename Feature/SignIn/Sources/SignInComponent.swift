//
//  SignInComponent.swift
//  SignIn
//
//  Created by 공태웅 on 12/27/24.
//

import SwiftUI
import SignInInterface
import Domain

public final class SignInComponent: SignInBuilder {
    
    public typealias SomeView = SignInView
    
    
    public init(dependency: SignInDependency) {
        self.dependency = dependency
    }
    
    private let dependency: SignInDependency
    
    @MainActor
    @ViewBuilder
    public func signInView(didSignIn: @escaping ((SignInResponse) -> Void)) -> SignInView {
        let viewModel = SignInViewModel(dependency: dependency, didSignIn: didSignIn)
        SignInView(viewModel: viewModel)
    }
}
