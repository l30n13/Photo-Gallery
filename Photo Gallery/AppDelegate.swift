//
//  AppDelegate.swift
//  Photo Gallery
//
//  Created by Mahbubur Rashid Leon on 6/6/22.
//

import UIKit
import IHProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupProgressHUD()
        return true
    }
}


extension AppDelegate {
    private func setupProgressHUD() {
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.set(minimumDismiss: 0.3)
    }
}
