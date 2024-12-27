//
//  SignInBuilder.swift
//  SignInInterfaces
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI
import Domain

public protocol SignInBuilder {
    associatedtype SomeView: View
    
    @MainActor
    @ViewBuilder
    func signInView(didSignIn: @escaping ((SignInResponse) -> Void)) -> SomeView
}
