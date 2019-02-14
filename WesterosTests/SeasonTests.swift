//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Eric Sans Alvarez on 14/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var season: Season!
    var firstEpisode: Episode!
    var lastEpisode: Episode!
    
    var firstDate: Date!
    var lastDate: Date!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        firstDate = formatter.date(from: "2011-04-24")
        lastDate = formatter.date(from: "2011-06-19")
        
        season = Season(name: "Season1", releaseDate: firstDate)
        firstEpisode = Episode(title: "\"Winter Is Coming\"", airDate: firstDate, season: season)
        lastEpisode = Episode(title: "\"Fire and Blood\"", airDate: lastDate, season: season)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeason_Existence() {
        XCTAssertNotNil(season)
    }
    
    func testSeason_AddEpisodes() {
        XCTAssertEqual(season.count, 0)
        season.add(episodes: firstEpisode, lastEpisode)
        XCTAssertEqual(season.count, 2)
    }
    
    func testSeason_IsCustomStringConvertible() {
        XCTAssertNotNil(season.description)
    }
    
    func testSeason_IsEquatable() {
        // Identity
        XCTAssertEqual(season, season)
        
        // Equality
        let sameSeason = Season(name: "Season1", releaseDate: firstDate)
        XCTAssertEqual(season, sameSeason)
        
        // Non-Equality
        let secondSeason = Season(name: "Season2", releaseDate: lastDate)
        XCTAssertNotEqual(season, secondSeason)
    }
    
    func testSeason_IsHashable() {
        XCTAssertNotNil(season.hashValue)
    }
    
    func testSeason_IsComparable() {
        // Approx. 31.558.000 seconds from Season1 to Season2
        let seconds = 31_557_600
        let newDate = firstDate.addingTimeInterval(TimeInterval(seconds))
        let secondSeason = Season(name: "Season2", releaseDate: newDate)
        XCTAssertLessThan(season, secondSeason)
    }
}
