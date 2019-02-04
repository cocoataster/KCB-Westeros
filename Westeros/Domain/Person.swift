//
//  Character.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 31/01/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import Foundation

final class Person {
    
    // MARK: Properties
    let name: String
    private let _alias: String?
    let house: House
    
    // Computable Variable
    var alias: String {
        get {
//            if let alias = _alias {
//                return alias
//            } else {
//                return ""
//            }
//            guard let alias = _alias else { return "" }
            return _alias ?? ""
        }
    }
    
    // MARK: Init
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        _alias = alias
        self.house = house
    }
    
    // Must call designated init with self.init
//    convenience init(name: String, house: House) {
//        self.init(name: name, alias: nil, house: house)
//    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    // Proxy will handle the Equatable and Hashable protocols
    var proxy: String {
        return "\(name) \(alias) \(house.name)"
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}
