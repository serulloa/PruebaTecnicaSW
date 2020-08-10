//
//  Film.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/**
 Modelo que define una película
 */
struct Film: BaseModel {
    
    var id: Int?
    var title: String?
    var overview: String?
    var voteAverage: Double?
    var releaseDate: String?
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
    
}
