//
//  MainViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 19/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class MainViewController: UISplitViewController {
    
    var houseListViewController: HouseListViewController
    var seasonListViewController: SeasonListViewController
    var houseDetailViewController: HouseDetailViewController
    var seasonDetailViewController: SeasonDetailViewController
    var tabBarVC = UITabBarController()

    init(houses: [House], seasons: [Season]) {
        houseListViewController = HouseListViewController(model: houses)
        houseDetailViewController = HouseDetailViewController(model: houseListViewController.lastHouseSelected())
        
        seasonListViewController = SeasonListViewController(model: seasons)
        seasonDetailViewController = SeasonDetailViewController(model: seasonListViewController.lastSeasonSelected())
        
        tabBarVC.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        tabBarVC.delegate = self
        
        viewControllers = [tabBarVC, houseDetailViewController.wrappedInNavigation()]
        preferredDisplayMode = .allVisible
        
        configureUI()
    }
    
    func configureUI() {
        tabBarVC.tabBar.tintColor = .black
        
        let houseIcon = tabBarVC.tabBar.items?[0]
        houseIcon?.image = UIImage(named: "HouseIcon")
        
        let seasonIcon = tabBarVC.tabBar.items?[1]
        seasonIcon?.image = UIImage(named: "SeasonIcon")
    }
}

extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (isCollapsed == false) {
            if tabBarController.selectedIndex == 0 {
                self.delegate = houseListViewController
                show(houseDetailViewController.wrappedInNavigation(), sender: self)
            } else {
                self.delegate = seasonListViewController
                show(seasonDetailViewController.wrappedInNavigation(), sender: self)
            }
        }
    }
}
