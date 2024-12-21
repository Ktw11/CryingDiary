//
//  SignInComponent.swift
//  SignIn
//
//  Created by 공태웅 on 12/21/24.
//

import SwiftUI

public protocol SignInBuilder {
    associatedtype SomeView: View
    
    @MainActor
    @ViewBuilder
    func signInView() -> SomeView
}