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
        title = "Character"
        memberImageView.image = UIImage()
        memberTitleLabel.text = model.fullName
    }
    
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo, let house = info[Const.houseKey.rawValue] as? House else { return }
        model = house.sortedMembers[0]
        updateUI()
    }
}
