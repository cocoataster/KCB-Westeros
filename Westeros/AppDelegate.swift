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
    var splitViewController: UISplitViewController!
    var houseListViewController: HouseListViewController!
    var seasonListViewController: SeasonListViewController!
    var houseDetailViewController: HouseDetailViewController!
    var seasonDetailViewController: SeasonDetailViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Load houses and seasons from Repository
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Create Master Controllers
        houseListViewController = HouseListViewController(model: houses)
        seasonListViewController = SeasonListViewController(model: seasons)
        
        // Create Detail Controllers
        houseDetailViewController = HouseDetailViewController(model: houses[0])
        seasonDetailViewController = SeasonDetailViewController(model: seasons[0])
        
        // Assign Delegates
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController

        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        
        // Last house selected (if any)
        //let lastHouseSelected = houseListViewController.lastHouseSelected()
        //let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [tabBarController, houseDetailViewController.wrappedInNavigation()]
        
        splitViewController.preferredDisplayMode = .allVisible
        
        // Assign rootViewController for window
        window?.rootViewController = splitViewController
        
        return true
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (splitViewController.isCollapsed == false) {
            if tabBarController.selectedIndex == 0 {
                splitViewController.delegate = houseListViewController
                splitViewController.show(houseDetailViewController.wrappedInNavigation(), sender: self)
            } else {
                splitViewController.delegate = seasonListViewController
                splitViewController.show(seasonDetailViewController.wrappedInNavigation(), sender: self)
            }
        }
    }
}

