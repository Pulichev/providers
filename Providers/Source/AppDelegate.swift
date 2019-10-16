//
//  AppDelegate.swift
//  Providers
//
//  Created by Victor Volnukhin on 03/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = self.navigationControllerWillSetCustomSettings()
        
        self.rootViewControllerWillSet(navigationController)
        
        return true
    }
    
    private func navigationControllerWillSetCustomSettings() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let providersStoryboardID: String = "ProvidersViewController"
        guard let providersViewController = storyboard.instantiateViewController(withIdentifier: providersStoryboardID) as? ProvidersViewController else {
            fatalError("View controller with Storyboard ID '\(providersStoryboardID)' was not found.")
        }
        
        providersViewController.providersAssembly = ProvidersAssembly()
        
        let navigationController = UINavigationController(rootViewController: providersViewController)
        
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
        return navigationController
    }
    
    private func rootViewControllerWillSet(_ newRootViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = newRootViewController
        window?.makeKeyAndVisible()
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
