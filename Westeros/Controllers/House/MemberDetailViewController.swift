//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 23/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var memberTitleLabel: UILabel!
    
    // MARK: - Properties
    var model: Person
    
    // MARK: - Initializers
    init(model: Person) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.name
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        print("MemberDetail has been deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.houseDidChange(notification:)), name: Notification.Name(Const.houseDidChangeNotificationName.rawValue), object: nil)
        updateUI()
    }
    
    func updateUI() {
        title = model.name
        memberImageView.image = UIImage(named: model.name)
        memberTitleLabel.text = model.fullName
        
        let backButton = UIBarButtonItem(title: model.house.name, style: .plain, target: self, action: Selector(("none")))
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc func houseDidChange(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }
}
