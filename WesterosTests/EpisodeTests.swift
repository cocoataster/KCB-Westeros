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
    
    var date: Date!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current,  year: 2018, month: 8, day: 22)
        let calendar = Calendar.current
        date = calendar.date(from: dateComponents)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEpisodeExistence() {
        let episode = Episode(title: "Episode1", airDate: date, season: Season(name: "Season1", releaseDate: date))
        XCTAssertNotNil(episode)
    }
}
