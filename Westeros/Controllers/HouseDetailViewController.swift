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
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    let model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        // If nil nibName looks for a nib file with same name as the class.
        // Bundle.init() future reference
        super.init(nibName: nil, bundle: Bundle.init(for: type(of: self)))
        title = model.name
    }
    
    // Chapuza de los de Cupertino relacionada con el miedo a nil
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        houseNameLabel.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
    }
    
    func setupUI() {
        let wikiBtn = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        navigationItem.rightBarButtonItem = wikiBtn
    }
    
    @objc func displayWiki() {
        // Display wiki page
        let wikiVC = WikiViewController(model: model)
        navigationController?.pushViewController(wikiVC, animated: true)
    }
}
