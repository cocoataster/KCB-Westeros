//
//  SeasonInfo.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 15/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import Foundation


struct EpisodeInfo: Decodable {
    let numOverall: Int
    let numInSeason: Int
    let title: String
    let directedBy: String
    let writtenBy: String
    let airDate: String
    let usViewers: String
}
