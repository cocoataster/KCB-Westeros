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
    var model: Season {
        didSet {
            updateUI()
        }
    }
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        title = "Overview"
        seasonTitleLabel.text = model.name
        seasonInfoLabel.text = model.description
    }
}

extension SeasonDetailViewController: SeasonViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        let seasonDetailViewController = SeasonDetailViewController(model: season)
        
        if (splitViewController?.isCollapsed == true) {
            navigationController?.pushViewController(seasonDetailViewController, animated: true)
        } else {
            self.model = season
        }
    }
}
