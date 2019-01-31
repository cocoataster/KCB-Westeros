//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Eric Sans Alvarez on 31/01/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import XCTest
@testable import Westeros

class CharacterTests: XCTestCase {
    
    var starkHouse: House!
    var starkSigil: Sigil!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is comming")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPersonExistence() {
        let character = Person(name: "Eddar", alias: "Ned", house: starkHouse)
        XCTAssertNotNil(character)
    }
    
    // to be implemented
    func testPersonHasFullName() {
        XCTAssertEqual(ned.fullName, "Eddar Stark")
    }

}
