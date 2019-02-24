//
//  Season.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 14/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    // MARK: Properties
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    // MARK: - Initializers
    init(name: String, releaseDate: Date) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = Episodes()
    }
}

// Methods for TableView purposes
extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episodes: Episode...) {
        for episode in episodes {
            guard episode.season == self else { return }
            _episodes.insert(episode)
        }
    }
}

// MARK: - Protocols

// Conform CustomStringConvertible to provide a description
extension Season: CustomStringConvertible {
    var description: String {
        return "\(name)"
    }
}

// Proxys for equality and comparison
extension Season {
    var proxyForEquality: String {
        return name
    }
    var proxyForComparison: Date {
        return releaseDate
    }
}

// Conform Equatable and Hashable to compare two Seasons by ID
extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// Conform Comparable to make a Collection of Seasons sortable
extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
