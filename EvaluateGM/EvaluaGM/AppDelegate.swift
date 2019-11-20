//
//  AppDelegate.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/12/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Thread.sleep(forTimeInterval: 2.0)
        // Override point for customization after application launch.
//        guard let rootVC = window?.rootViewController as? LoginViewController else {
//            return true
//        }
//        guard let tabBarController = rootVC.presentedViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers else {
//            print("Can not find TabBarViewController")
//            return true
//        }
        
//        guard let tabBarController = window?.rootViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers else {
//            return true
//        }
//
//        for (index, viewController) in viewControllers.enumerated() {
//            if let navigationController = viewController as? UINavigationController, let forkliftViewController = navigationController.viewControllers.first as? ForkliftTableViewController {
//                print("Es ForkliftTableViewController")
//                forkliftViewController.stateController = self.stateController
//                forkliftViewController.warehouseOnly = index == 1
//            }
//        }
        return true
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

