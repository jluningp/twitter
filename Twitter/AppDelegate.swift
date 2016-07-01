//
//  AppDelegate.swift
//  Twitter
//
//  Created by Jeanne Luning Prak on 6/27/16.
//  Copyright © 2016 Jeanne Luning Prak. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if User.currentUser == nil {
            let viewController = LoginViewController()
            let navController = UINavigationController(rootViewController: viewController)
            Error.navMethod = {() -> Void in
                self.toLogoutScreen(navController)
            }
            window!.rootViewController = navController
        } else {
            let viewController = ViewController()
            let navController = UINavigationController(rootViewController: viewController)
            Error.navMethod = {() -> Void in
                self.toLogoutScreen(navController)
            }
            window!.rootViewController = navController
        }
        window!.makeKeyAndVisible()
        return true
    }
    
    func toLogoutScreen(navController : UINavigationController) {
        let nextVC = LoginViewController()
        navController.presentViewController(nextVC, animated: false, completion: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if let urlQuery = url.query {
            APICall.logInAndSetUser(urlQuery, toExecute: goToMainScreen)
        } else {
            Error.callErrorAndLogout("Failed to log in")
            return false
        }
        return true
    }
    
    func goToMainScreen() {
        let viewController = ViewController()
        window!.rootViewController = UINavigationController(rootViewController: viewController)

    }


}

