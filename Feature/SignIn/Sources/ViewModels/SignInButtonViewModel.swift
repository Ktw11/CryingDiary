//
//  SignInButtonViewModel.swift
//  SignIn
//
//  Created by 공태웅 on 12/15/24.
//

import SwiftUI
import UseCase

struct SignInButtonViewModel: Identifiable {
    let id: String
    let icon: Image
    let backgroundColor: Color

    init(from type: SignInType) {
        self.id = type.rawValue
        self.backgroundColor = type.backgroundColor
        self.icon = type.icon
    }
}

private extension SignInType {
    var icon: Image {
        switch self {
        case .apple:
            SignInAsset.Image.icApple.swiftUIImage
        case .kakao:
            SignInAsset.Image.icKakao.swiftUIImage
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .apple:
            SignInAsset.Color.appleBackground.swiftUIColor
        case .kakao:
            SignInAsset.Color.kakaoBackground.swiftUIColor
        }
    }
}
