//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 04/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        // If nil nibName looks for a nib file with same name as the class.
        // Bundle.init() future reference
        super.init(nibName: nil, bundle: Bundle.init(for: type(of: self)))
    }
    
    // Chapuza de los de Cupertino relacionada con el miedo a nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setupUI()
    }
    
    // MARK: - Sync
    func updateUI() {
        self.title = "\(model.name)'s House"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    func setupUI() {
        let wikiBtn = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersBtn = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        navigationItem.rightBarButtonItems = [wikiBtn, membersBtn]
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func displayWiki() {
        // Create wiki page
        let wikiVC = WikiViewController(model: model)
        navigationController?.pushViewController(wikiVC, animated: true)
    }
    
    @objc func displayMembers() {
        // Create Controller
        let membersVC = MemberListViewController(model: model.sortedMembers)
        navigationController?.pushViewController(membersVC, animated: true)
    }
}

extension HouseDetailViewController: HouseViewControllerDelegate {
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse house: House) {
        if (viewController.splitViewController?.isCollapsed == true) {
            let houseDetailViewController = HouseDetailViewController(model: house)
            viewController.navigationController?.pushViewController(houseDetailViewController, animated: true)
        } else {
            self.model = house
            updateUI()
        }
    }
}
