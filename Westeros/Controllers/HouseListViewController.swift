//
//  HouseListViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 07/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [House]
    
    // MARK: - Init
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        // Create Detail Controller
        let houseDetailViewController = HouseDetailViewController(model: house)
        
        // Show with push
        //navigationController?.pushViewController(houseDetailViewController, animated: true)
        
        showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: self)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HouseListViewController: UISplitViewControllerDelegate {
    
}
