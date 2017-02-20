//
//  AppDelegate.swift
//  MatchBox Closet
//
//  Created by Prasanna kumar on 23/01/17.
//  Copyright © 2017 Prasanna kumar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Fabric
import Crashlytics

func getDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dict_data: NSMutableDictionary?
    
    
    fileprivate func createMenuView() {
        
        // create viewController code...
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        //let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        //let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
        
        
        let mainViewController = MainViewController(nibName:nil, bundle: nil)
        let leftViewController = LeftViewController(nibName:nil, bundle: nil)
        let rightViewController = RightViewController(nibName:nil, bundle: nil)
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func createPageviews() {
        
        //create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pageViewController = storyboard.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        
        //let viewController = PageViewController(nibName:nil, bundle: nil) //ViewController = Name of your controller
        let navigationController = UINavigationController(rootViewController: pageViewController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle =   UIStatusBarStyle.lightContent
        
        Fabric.with([Crashlytics.self])
        
        IQKeyboardManager.sharedManager().enable = true
        
        Utilities.copyFile(fileName: "MatchBox_closet.sqlite")
        
        
        //let result = UserDefaults.standard.value(forKey: "isLogged") as! String
        var navigationController = UINavigationController()

        if let result : String = UserDefaults.standard.object(forKey: "isLogged") as? String {
            
            if result == "true" {
                
                createMenuView()
                return true
                
            } else {
                let accountVC = AccountViewController(nibName:nil, bundle: nil)
                navigationController = UINavigationController(rootViewController: accountVC)
            }
            
        } else {
            
            let accountVC = AccountViewController(nibName:nil, bundle: nil)
            navigationController = UINavigationController(rootViewController: accountVC)
        }
        
        
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        
        
        
        //self.createMenuView()
        //self.createPageviews()
        
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

