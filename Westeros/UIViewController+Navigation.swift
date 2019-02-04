//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 05/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
