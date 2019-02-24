//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 07/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

// Define our own Delegate
protocol HouseViewControllerDelegate: AnyObject {
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    weak var delegate: HouseViewControllerDelegate?
    
    // MARK: - Init
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Houses"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // What house?
        let house = model[indexPath.row]
        
        // Create cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell") ?? UITableViewCell(style: .default, reuseIdentifier: "HouseCell")
        
        // Update View
        cell.textLabel?.text = house.name
        cell.imageView?.image = house.sigil.image
        
        // Return cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // What House has been selected?
        let house = model[indexPath.row]
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Notifications
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(rawValue: Const.houseDidChangeNotificationName.rawValue), object: self, userInfo: [Const.houseKey.rawValue : house])
        
        // Send Notification
        notificationCenter.post(notification)
        
        saveLastSelectedHouse(at: indexPath.row)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HouseListViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at index: Int) {
        // Write on User Defaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: Const.lastHouseKey.rawValue)
        userDefaults.synchronize()
    }
    
    func lastHouseSelected() -> House {
        //Read from User Defaults
        let index = UserDefaults.standard.integer(forKey: Const.lastHouseKey.rawValue)
        return house(at: index)
    }
    
    func house(at index: Int) -> House {
        return model[index]
    }
}
