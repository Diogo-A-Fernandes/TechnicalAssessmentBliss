//
//  AppDelegate.swift
//  BlissApp
//
//  Created by Diogo on 8/7/25.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: HomeScreenViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        let emojiRepo = EmojisDataRepository()
        emojiRepo.deleteAll()
        
        let avtRepo = AvatarsDataRepository()
        avtRepo.deleteAll()
        
        let appleRepo = AppleDataRepository()
        appleRepo.deleteAll()
        
        return true
    }
    
    
}

