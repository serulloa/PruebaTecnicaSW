//
//  BaseProviderParamsDTO.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

protocol BaseProviderParamsDTO: Codable {
    
}

extension BaseProviderParamsDTO {
    
    /**
     Se utiliza para la codificación de un modelo a los parámentros de la llamada a la API en los Providers
     */
    func encode() -> [String: Any] {
        
        guard let jsonData = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            else { return [String: Any]() }

        return json
    }
    
}

extension Array where Element: BaseProviderParamsDTO {
    
    /**
     Se utiliza para la codificación de un array de modelos a los parámentros de la llamada a la API en los Providers
    */
    func encode() -> [[String: Any]] {
        
        guard let jsonData = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
            else { return [[String: Any]]() }

        return json
    }
    
}
