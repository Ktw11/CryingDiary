//
//  SignInButtonViewModel.swift
//  SignIn
//
//  Created by 공태웅 on 12/15/24.
//

import SwiftUI

struct SignInButtonViewModel: Equatable {
    let type: SignInType
    let icon: Image
    let backgroundColor: Color
    
    init(type: SignInType) {
        self.type = type
        self.icon = type.icon
        self.backgroundColor = type.backgroundColor
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
