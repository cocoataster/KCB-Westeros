//
//  Repository.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 06/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    // Only get since will be read-only
    var houses: [House] { get }
    typealias HouseFilter = (House) -> Bool
    func house(named: String) -> House?
    func houses(filteredBy theFilter: HouseFilter) -> [House]
}

// Para que no se queje el compilador
final class LocalFactory: HouseFactory {
    var houses: [House] {
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "Lobo Huargo")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall")!, description: "Dragón tricéfalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", wikiURL: starkURL)
        let lannisterkHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear my roar", wikiURL: lannisterURL)
        let targatianHouse = House(name: "Targarian", sigil: targaryenSigil, words: "Fuego y Sangre", wikiURL: targaryenURL)
        
        // Add chars for later
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterkHouse)
        let cersei = Person(name: "Cersei", house: lannisterkHouse)
        let jaime = Person(name: "Jaime", alias: "El Matareyes", house: lannisterkHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targatianHouse)
        
        starkHouse.add(persons: robb, arya)
        lannisterkHouse.add(persons: tyrion, cersei, jaime)
        targatianHouse.add(person: dani)
        
        return [targatianHouse, starkHouse, lannisterkHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        //let house = houses.filter { $0.name == name }.first
        let house = houses.first { $0.name.uppercased() == name.uppercased() }
        return house
    }
    
    func houses(filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }
}

protocol SeasonFactory {
    // Read-Only
    var seasons: [Season] { get }
    typealias SeasonFilter = (Season) -> Bool
    func season(named: String) -> Season?
    func seasons(filteredBy filter: SeasonFilter) -> [Season]
    func dateFromStr(_ str: String) -> Date?
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        let episode1 = Episode(title: "Winter Is Coming", airDate: dateFromStr("2011-04-17")!, season: Season(name: "Season1", releaseDate: dateFromStr("2011-04-17")!))
        let episode2 = Episode(title: "The Kingsroad", airDate: dateFromStr("2011-04-24")!, season: Season(name: "Season2", releaseDate: dateFromStr("2011-04-17")!))
        
        let season1 = Season(name: "Season1", releaseDate: dateFromStr("2011-04-17")!)
        
        season1.add(episodes: episode1, episode2)
        
        return [season1].sorted()
    }
    
    func season(named: String) -> Season? {
        #warning ("To be implemented")
        return Season(name: "", releaseDate: Date())
    }
    
    func seasons(filteredBy filter: (Season) -> Bool) -> [Season] {
        return seasons.filter(filter)
    }
    
    func dateFromStr(_ strDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: strDate)
    }
    
}
