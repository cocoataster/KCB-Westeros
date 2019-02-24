//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 18/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Initializers
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = model.title
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
        print("EpisodeDetail has been deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.seasonDidChange(notification:)), name: Notification.Name(Const.seasonDidChangeNotificationName.rawValue), object: nil)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        title = model.title
        episodeImageView.image = UIImage(named: "EpisodeImg.gif")!
        episodeTitleLabel.text = model.title
    }
    
    @objc func seasonDidChange(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }
}
