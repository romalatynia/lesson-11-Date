//
//  AppDelegate.swift
//  Date
//
//  Created by Harbros47 on 29.12.20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var previousDate = Date(timeIntervalSince1970: 0)
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] (_) in
            print(self?.previousDate ?? Date())
            self?.previousDate += 60 * 60 * 24
            
            let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                guard let viewController = topController as? ViewController else { return }
                viewController.congratulation(date: self?.previousDate ?? Date())
            }
        }
    }
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        timer()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
