//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 07/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

protocol HouseSelectionDelegate {
    func houseSelected(_ newHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    var delegate: HouseSelectionDelegate?
    
    // MARK: - Init
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // What house?
        let house = model[indexPath.row]
        
        // Create cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "HouseCell")
        }
        
        /* Better use
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: IndexPath)
        */
        
        // Update View
        cell?.textLabel?.text = house.name
        cell?.imageView?.image = house.sigil.image
        
        // Return cell
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // What House has been selected?
        let house = model[indexPath.row]
        
        if (splitViewController?.isCollapsed == true) {
            // Create Detail Controller
            let houseDetailViewController = HouseDetailViewController(model: house)
            // Show with push
            navigationController?.pushViewController(houseDetailViewController, animated: true)
        } else {
            delegate?.houseSelected(house)
        }
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
