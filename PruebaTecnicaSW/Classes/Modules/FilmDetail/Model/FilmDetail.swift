//
//  FilmDetail.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 10/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/**
 Modelo que define el detalle de una película
 */
struct FilmDetail: BaseModel {
    
    var backdropPath: String?
    var genres: [Genre]?
    var id: Int?
    var overview: String?
    var posterPath: String?
    var tagline: String?
    var title: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id, overview
        case posterPath = "poster_path"
        case tagline, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}
