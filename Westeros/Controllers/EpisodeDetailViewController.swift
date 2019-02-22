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
    @IBOutlet weak var episodeInfoLabel: UILabel!
    
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Initializers
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
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
        title = "Episode Overview"
        episodeImageView.image = UIImage(named: "EpisodeImg")!
        episodeTitleLabel.text = model.title
        episodeInfoLabel.text = model.description
    }
    
    @objc func seasonDidChange(notification: Notification) {
        guard let info = notification.userInfo,
            let season = info[Const.seasonKey.rawValue] as? Season else { return }
        model = season.sortedEpisodes[0]
        updateUI()
        //let backButton = UIBarButtonItem(title: season.name, style: .plain, target: self, action: Selector(("none")))
        //navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
