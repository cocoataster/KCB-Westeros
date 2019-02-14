//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Eric Sans Alvarez on 14/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var season: Season?
    var episode: Episode!
    
    var date: Date!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.date(from: "2011-04-24")
        
        season = Season(name: "Season1", releaseDate: date)
        episode = Episode(title: "Episode1", airDate: date, season: season)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEpisode_Existence() {
        XCTAssertNotNil(episode)
    }
    
    func testEpisode_IsCustomStringConvertible() {
        XCTAssertNotNil(episode.description)
    }
    
    func testEpisode_IsEquatable() {
        // Identity
        XCTAssertEqual(episode, episode)
        
        // Equality
        let sameEpisode = Episode(title: "Episode1", airDate: date, season: season)
        XCTAssertEqual(episode, sameEpisode)
        
        // Non-Equality
        let diffEpisode = Episode(title: "Episode2", airDate: date, season: season)
        XCTAssertNotEqual(episode, diffEpisode)
    }
    
    func testEpisode_IsHashable() {
        XCTAssertNotNil(episode.hashValue)
    }
    
    func testEpisode_IsComparable() {
        // Approx. 5.200.000 seconds from Episode1 to Episode10
        let seconds = 5_200_000
        let newDate = date.addingTimeInterval(TimeInterval(seconds))
        let lastEpisode = Episode(title: "Episode10", airDate: newDate, season: season)
        XCTAssertLessThan(episode, lastEpisode)
    }
}
