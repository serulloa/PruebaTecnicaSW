//
//  FilmList.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/**
 Modelo que define un listado de películas
 */
struct FilmList: BaseModel {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Film]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}
