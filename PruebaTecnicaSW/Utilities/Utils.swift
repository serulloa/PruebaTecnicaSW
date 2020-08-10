//
//  Utils.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

class Utils {
    
    static func getXib(xibFile: XibFile) -> String {
        return xibFile.rawValue
    }
    
    static func getAPIKey() -> String? {
        return Bundle.main.infoDictionary?["TMDB_API_key"] as? String
    }
    
    static func getLanguageCode() -> String? {
        return Locale.current.languageCode == "es" ? "es-ES" : "en-US"
    }
    
    static func getErrorString(errorType: ErrorType) -> String {
        switch errorType {
        case .badGateway, .forbidden, .internalServerError, .notFound, .preConditionFailed, .unauthorized, .unknownError:
            return LocalizedKeys.Error.generic
        case .networkError:
            return LocalizedKeys.Error.network
        }
    }
    
}
