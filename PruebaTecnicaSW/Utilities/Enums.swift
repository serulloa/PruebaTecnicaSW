//
//  Enums.swift
//  PruebaTecnicaMeep
//
//  Created by Sergio Ulloa López on 20/07/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

public enum XibFile: String {
    case filmListView = "FilmListViewController"
    case filmDetailView = "FilmDetailViewController"
}

enum AcceptResponseType {
    case json
    case pdf
    case xml
    case text
}

enum ErrorType: Int {
    case internalServerError = 500
    case badGateway = 502
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case preConditionFailed = 412
    case networkError = 0
    case unknownError = -1
}
