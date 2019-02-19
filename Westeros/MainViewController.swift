//
//  MainViewController.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 19/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

class MainViewController: UISplitViewController {
    
    let houses = Repository.local.houses
    let seasons = Repository.local.seasons

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
