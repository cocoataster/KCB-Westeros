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
        
        // Create models
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is Coming")
        
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "Un Leon Rampante")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my Roar")
        
        // Create controller
        let starkVC = HouseDetailViewController(model: starkHouse)
        let lannisterVC = HouseDetailViewController(model: lannisterHouse)
        
//        let starkNavVC = UINavigationController(rootViewController: starkVC)
//        let lannisterNavVC = UINavigationController(rootViewController: lannisterVC)
        
        // Create combiner
        let tabBC = UITabBarController()
        tabBC.viewControllers = [starkVC.wrappedInNavigation(), lannisterVC.wrappedInNavigation()]
        
        // Navigation Controller
        //let starkNavigationController = UINavigationController(rootViewController: starkVC)
        
        // Assign rootViewController for window
        window?.rootViewController = tabBC
        
        return true
    }

}

