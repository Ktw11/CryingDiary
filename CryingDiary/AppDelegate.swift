//
//  AppDelegate.swift
//  CryingDiary
//
//  Created by 공태웅 on 5/16/24.
//

import Foundation
import FirebaseCore
import KakaoSDKCommon
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: AppKeys.kakaoAppKey)

        return true
    }
}
