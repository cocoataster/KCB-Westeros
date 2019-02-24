//
//  Date+String.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 23/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import Foundation

extension String {
    func dateFromStr() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: self)
    }
}

extension Date {
    func strFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy"
        
        return formatter.string(from: self)
    }
}
