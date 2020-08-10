//
//  URLEndpoint.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/*+
 Estructura que contiene todos los endpoints a los que se llaman en la app
 */
struct URLEndpoint {
    
    static var filmList = "movie/popular"
    static var filmDetail = "movie/"
    
}

/**
 Tipos de anchos de imágen utilizados en la app
 */
enum ImageWidth: String {
    case poster = "w185"
    case backdrop = "w780"
}

extension URLEndpoint {
    
    static func getBaseUrl() -> String {
        return "https://api.themoviedb.org/3"
    }
    
    static func getImageBaseUrl(width: ImageWidth) -> String {
        return "https://image.tmdb.org/t/p/\(width.rawValue)"
    }
    
    static func getImageUrl(path: String, width: ImageWidth) -> String {
        return getImageBaseUrl(width: width) + path
    }
    
}

