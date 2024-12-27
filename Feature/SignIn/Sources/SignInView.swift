//
//  SignInView.swift
//  SignIn
//
//  Created by 공태웅 on 12/12/24.
//

import SwiftUI
import SignInInterface

public struct SignInView: View {
    
    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    private let viewModel: SignInViewModel
    
    public var body: some View {
        ZStack {
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
                    ForEach(viewModel.buttonViewModels, id: \.type) { vm in
                        Button(action: {
                            viewModel.didTap(type: vm.type)
                        }, label: {
                            SignInButton(viewModel: vm)
                        })
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            
            Color.gray.opacity(0.2)
                .overlay(alignment: .center) {
                    LoadingView()
                }
                .opacity(viewModel.showProgressView ? 1.0 : 0)
                .ignoresSafeArea()
        }
    }
}

#warning("Common UI로 이동 필요")
private struct LoadingView: View {
    @State private var animate = false
    
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: .primary, location: 0),
            Gradient.Stop(color: .primary.opacity(0.4), location: 1.0)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        Circle()
            .stroke(gradient, lineWidth: 2.5)
            .frame(width: 25, height: 25)
            .rotationEffect(Angle(degrees: animate ? 360 : 0))
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear {
                animate.toggle()
            }
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
    SignInView(
        viewModel: .init(
            dependency: .init(
                signInTypes: [.apple, .kakao],
                useCase: SignInUseCaseMock(),
                appState: AppStateMock()
            ),
            didSignIn: { _ in }
        )
    )
}
