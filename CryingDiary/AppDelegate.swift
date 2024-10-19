//
//  AppDelegate.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import Foundation
import UIKit
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: AppKeys.kakaoAppKey)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return KakaoSDKAuth.AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
}
