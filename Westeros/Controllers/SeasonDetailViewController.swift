//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 19/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    @IBOutlet weak var seasonImageView: UIImageView!
    @IBOutlet weak var seasonTitleLabel: UILabel!
    @IBOutlet weak var seasonInfoLabel: UILabel!
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initializers
    init(model: Season) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setupUI()
    }
    
    func updateUI() {
        title = "Season Overview"
        seasonTitleLabel.text = model.name
        seasonInfoLabel.text = model.description
        seasonImageView.image = UIImage(named: model.name)
    }
    
    func setupUI() {
        let episodesBtn = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(showEpisodes))
        navigationItem.rightBarButtonItems = [episodesBtn]
    }
    
    @objc func showEpisodes() {
        let episodeListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        if (viewController.splitViewController?.isCollapsed == true) {
            let seasonDetailViewController = SeasonDetailViewController(model: season)
            viewController.navigationController?.pushViewController(seasonDetailViewController, animated: true)
        } else {
            self.model = season
            updateUI()
        }
    }
}
