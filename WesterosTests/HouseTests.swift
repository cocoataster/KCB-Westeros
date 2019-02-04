//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Eric Sans Alvarez on 31/01/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "Leon Rampante")
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is comming")
        lannisterHouse = House(name: "Lannister", sigil: starkSigil, words: "Hear my roar")
        
        robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyru", alias: "El Enano", house: lannisterHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
        // Given - When - Then
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
    }
    
    func testSigilExistence() {
        XCTAssertNotNil(starkSigil)
    }
    
    func testHouseAddPersons() {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 1)
    }
    
    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseEquality() {
        XCTAssertEqual(starkHouse, starkHouse)
        
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Winter is comming")
        XCTAssertEqual(starkHouse, jinxed)
        
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }

}
