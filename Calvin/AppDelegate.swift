//
//  AppDelegate.swift
//  Calvin
//
//  Created by Arion Zimmermann on 27.01.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    @available(iOS 10.0, *)
    static let center = UNUserNotificationCenter.current()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 10.0, *) {
            AppDelegate.center.delegate = self
            
            application.setMinimumBackgroundFetchInterval(30)
            
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            AppDelegate.center.requestAuthorization(options: options) {
                (granted, error) in
                if !granted {
                    print(error ?? "Undefined")
                }
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        };
        

        AZEntrepriseServer.login(controller: window?.rootViewController, userHash: UserDefaults.standard.string(forKey: "user-hash"), onResponse: loginResponse)
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AZEntrepriseServer.login(controller: nil, userHash: UserDefaults.standard.string(forKey: "user-hash"), onResponse: loginResponse)
        completionHandler(.newData)
    }
    
    func loginResponse(success : Bool) {
        if !success {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                self.window?.rootViewController?.present(storyboard.instantiateViewController(withIdentifier: "tutorial"), animated: true, completion: nil)
            }
        } else {
            AZEntrepriseServer.dummyOnResponse(dummy: true)
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

