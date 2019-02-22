//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 07/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.houseDidChange(notification:)), name: Notification.Name(Const.houseDidChangeNotificationName.rawValue), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo,
            let house = info[Const.houseKey.rawValue] as? House else { return }
        model = house.sortedMembers
        tableView.reloadData()
        let backButton = UIBarButtonItem(title: house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - UITableViewDelegate

extension MemberListViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create current person
        let person = model[indexPath.row]
        
        // Create cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "PersonCell")
        }
        
        
        // Update UI
        cell?.textLabel?.text = person.fullName
        cell?.detailTextLabel?.text = person.alias
        
        // Return cell
        return cell!
    }
    
    
}
