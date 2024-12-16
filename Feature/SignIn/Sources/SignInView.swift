//
//  SignInView.swift
//  SignIn
//
//  Created by 공태웅 on 12/12/24.
//

import SwiftUI

public struct SignInView: View {
    
    var viewModel: SignInViewModel
    
    public var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 40) {
                SignInAsset.Image.imgSignInTitle.swiftUIImage
                SignInAsset.Image.imgSignInMain.swiftUIImage
            }
            
            Spacer()
            
            Text("SNS 계정으로 간편 로그인")
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(SignInAsset.Color.description.swiftUIColor)

            HStack(spacing: 18) {
                ForEach(viewModel.signInTypes, id: \.self) { type in
                    Button(action: {
                        viewModel.didTap(type: type)
                    }, label: {
                        SignInButton(viewModel: .init(type: type))
                    })
                }
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

private struct SignInButton: View {
    let viewModel: SignInButtonViewModel

    var body: some View {
        viewModel.backgroundColor
            .overlay(alignment: .center) {
                viewModel.icon
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
}

#Preview {
    SignInView(viewModel: .init(signInTypes: [.apple, .kakao]))
}
