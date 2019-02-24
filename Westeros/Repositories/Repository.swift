//
//  Repository.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 06/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import UIKit

enum HouseName: String {
    case Stark = "Stark"
    case Lannister = "Lannister"
    case Targarien = "Targarien"
}

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    // Only get since will be read-only
    var houses: [House] { get }
    typealias HouseFilter = (House) -> Bool
    func house(name: HouseName) -> House?
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
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter Is Coming", wikiURL: starkURL)
        let lannisterkHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Hear Me Roar", wikiURL: lannisterURL)
        let targatianHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fire and Blood", wikiURL: targaryenURL)
        
        // Add chars for later
        let eddard = Person(name: "Eddard", alias: "The Quiet Wolf", house: starkHouse)
        let arya = Person(name: "Arya", alias: "Lumpyhead", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "The Imp", house: lannisterkHouse)
        let cersei = Person(name: "Cersei",alias: "Light of the West", house: lannisterkHouse)
        let jaime = Person(name: "Jaime", alias: "Kingslayer", house: lannisterkHouse)
        let dani = Person(name: "Daenerys", alias: "Dragonmother", house: targatianHouse)
        
        starkHouse.add(persons: eddard, arya)
        lannisterkHouse.add(persons: tyrion, cersei, jaime)
        targatianHouse.add(person: dani)
        
        return [targatianHouse, starkHouse, lannisterkHouse].sorted()
    }
    
    func house(name: HouseName) -> House? {
        let house = houses.first { $0.name.uppercased() == name.rawValue.uppercased() }
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
    func season(dated: Date) -> Season?
    func seasons(filteredBy filter: SeasonFilter) -> [Season]
}

extension LocalFactory: SeasonFactory {
    enum SeasonNumber: String {
        case Season1 = "Season1"
        case Season2 = "Season2"
        case Season3 = "Season3"
        case Season4 = "Season4"
        case Season5 = "Season5"
        case Season6 = "Season6"
        case Season7 = "Season7"
    }
    
    func loadInfo(season: SeasonNumber) -> SeasonInfo? {
        guard let url = Bundle.main.url(forResource: season.rawValue, withExtension: "json") else { fatalError() }
        
        do {
            let data = try Data(contentsOf: url)
            let seasonInfo = try JSONDecoder().decode(SeasonInfo.self, from: data)
            return seasonInfo
        } catch {
            fatalError()
        }
        return nil
    }
    
    var seasons: [Season] {
        var result = [Season]()
        
        for n in 1...7 {
            let episodeNum = "Season\(n)"
            let seasonInfo = loadInfo(season: LocalFactory.SeasonNumber.init(rawValue: episodeNum)!)!
            let season = Season(name: seasonInfo.title, releaseDate: seasonInfo.releaseDate.dateFromStr()!)
            
            for episodeInfo in seasonInfo.episodes {
                let episode = Episode(title: episodeInfo.title, airDate: episodeInfo.airDate.dateFromStr()!, season: season)
                season.add(episodes: episode)
            }
            result.append(season)
        }
        return result
    }
    
    func season(dated date: Date) -> Season? {
        let season = seasons.first { $0.releaseDate == date }
        return season
    }
    
    func seasons(filteredBy filter: (Season) -> Bool) -> [Season] {
        return seasons.filter(filter)
    }
}
