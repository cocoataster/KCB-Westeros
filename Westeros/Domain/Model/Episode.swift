//
//  Episode.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 14/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import Foundation

final class Episode {
    
    // MARK: - Properties
    let title: String
    let airDate: Date
    weak var season: Season?
    
    // MARK: - Initializers
    init(title: String, airDate: Date, season: Season?) {
        self.title = title
        self.airDate = airDate
        self.season = season
    }
}

// MARK: - Protocols

// Conform CustomStringConvertible to provide a description
extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title)"
    }
}

// Proxys
extension Episode {
    
    var proxyForEquality: String {
        return title
    }
    
    var proxyForComparison: Date {
        return airDate
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
