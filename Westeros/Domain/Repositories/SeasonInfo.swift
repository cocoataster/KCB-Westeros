//
//  SeasonInfo.swift
//  Westeros
//
//  Created by Eric Sans Alvarez on 18/02/2019.
//  Copyright © 2019 Eric Sans Alvarez. All rights reserved.
//

import Foundation

struct SeasonInfo: Decodable {
    var title: String
    var releaseDate: String
    var episodes: [EpisodeInfo]
}
