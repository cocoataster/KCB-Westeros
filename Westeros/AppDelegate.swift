//
//  AppDelegate.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 31/01/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .cyan
        
        // Load houses from Repository
        let houses = Repository.local.houses
        
        // Create Controllers (Master and Detail for iPad)
        let houseListViewController = HouseListViewController(model: houses).wrappedInNavigation()
        // #warning ("Force unwrapped to be removed")
        let houseDetailViewController = HouseDetailViewController(model: houses.first!).wrappedInNavigation()
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [houseListViewController, houseDetailViewController]
        
        // Assign rootViewController for window
        window?.rootViewController = splitViewController
        
        return true
    }

}

