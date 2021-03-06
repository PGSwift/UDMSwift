//
//  AppDelegate.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let reachability = ReachabilityManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Check NetWork
        reachability.startCheckConnectNetwork()
        
        //Caches
        CacheManager.shareInstance
        
        // setUp Theme()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : ChameleonManger.theme()]
        self.window?.tintColor = ChameleonManger.theme()
        
        // MARK: - Init and configuration Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    // MARK: - [START openurl]
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let stringURL = url.absoluteString
        if stringURL.containsString("fb1615266445438059") {
            if #available(iOS 9.0, *) {
                return FBSDKApplicationDelegate.sharedInstance().application(app, openURL: url, sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String?, annotation:options[UIApplicationOpenURLOptionsAnnotationKey])
            } else {
                return true
                // Fallback on earlier versions
            }
        }
        if #available(iOS 9.0, *) {
            return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String?, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        } else {
            // Fallback on earlier versions
            return true
        }
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
        FBSDKAppEvents.activateApp()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        reachability.stopCheckConnectNetwork()
    }


}

