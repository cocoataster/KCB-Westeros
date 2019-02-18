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
        
        // Load houses and seasons from Repository
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Create Controllers (Master and Detail for iPad)
        let houseListViewController = HouseListViewController(model: houses).wrappedInNavigation()
        
        let seasonListViewController = SeasonListViewController(model: seasons).wrappedInNavigation()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [houseListViewController, seasonListViewController]
        
        let houseDetailViewController = HouseDetailViewController(model: houses[0])
        //let seasonDetailViewController = SeasonDetailViewController(model: seasons[0])
        
        // Last house selected (if any)
        //let lastHouseSelected = houseListViewController.lastHouseSelected()
        
        //let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        // Assign Delegate
        //houseListViewController.delegate = houseDetailViewController
        
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [tabBarController, houseDetailViewController.wrappedInNavigation()]
        
        //splitViewController.delegate = houseListViewController
        //splitViewController.preferredDisplayMode = .allVisible
        
        // Assign rootViewController for window
        window?.rootViewController = splitViewController
        
        return true
    }
}

