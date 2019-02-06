//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Eric Sans Alvarez on 06/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    var houses: [House]!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        houses = Repository.local.houses
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseExistence() {
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepositoryHouseCount() {
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayofHouses() {
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitive() {
        let stark = Repository.local.house(named: "StArk")
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark?.name, "Stark")
    }
    
    func testLocalRepository_HousesFilteredBy_ReturnsTheCorrectValue() {
        /*let filtered = Repository.local.houses {
            // Return all Houses with 1 member
            $0.count == 1
        }*/
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        XCTAssertEqual(filtered.count, 1)
    }

}
