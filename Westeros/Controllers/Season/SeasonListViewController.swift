//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 18/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

// Define our own Delegate
protocol SeasonViewControllerDelegate: AnyObject {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [Season]
    weak var delegate: SeasonViewControllerDelegate?
    
    // MARK: - Initializers
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Seasons"
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
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let season = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SeasonCell")
        }

        // Configure the cell...
        cell?.textLabel?.text = season.name
        //cell?.detailTextLabel?.text = season.description

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = model[indexPath.row]
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        // Notifications
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(rawValue: Const.seasonDidChangeNotificationName.rawValue), object: self, userInfo: [Const.seasonKey.rawValue : season])
        
        // Send Notification
        notificationCenter.post(notification)
        
        //saveLastSelectedHouse(at: indexPath.row)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SeasonListViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
