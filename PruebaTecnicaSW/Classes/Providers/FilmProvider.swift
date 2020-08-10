//
//  FilmProvider.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/**
 Clase que realiza las llamadas pertinentes a la API para la obtención de información
 relacionada con las películas como, por ejemplo, el listado de películas populares o
 los detalles de una película
 */
class FilmProvider: BaseProvider {
    
    /**
     Realiza una llamada para obtener el listado de películas populares. Una vez recogido
     los datos, los parsea al modelo FilmList
     */
    func getFilmList(success: @escaping (FilmList?) -> Void, failure: @escaping (ErrorType) -> Void) {
        let dto = FilmDTO(api_key: Utils.getAPIKey(), language: Utils.getLanguageCode())
        
        _ = self.request(dto: FilmProviderRequest.getFilmListConstants(params: dto), success: { data in
            let model = BaseProvider.parseToServerModel(parserModel: FilmList.self, data: data)
            success(model)
        }, failure: { error in
            failure(error)
        })
    }
    
    /**
     Realiza una llamada para obtener los detalles de una película según un identificador
     (movieId) dado. Una vez recogidos los datos, los parsea al modelo FilmDetail
     */
    func getDetail(movieId: String?, success: @escaping (FilmDetail?) -> Void, failure: @escaping (ErrorType) -> Void) {
        let dto = FilmDTO(api_key: Utils.getAPIKey(), language: Utils.getLanguageCode())
        
        _ = self.request(dto: FilmProviderRequest.getFilmDetailConstants(params: dto, movieId: movieId ?? ""), success: { data in
            let model = BaseProvider.parseToServerModel(parserModel: FilmDetail.self, data: data)
            success(model)
        }, failure: { error in
            failure(error)
        })
    }
    
}

struct FilmDTO: BaseProviderParamsDTO {
    var api_key: String?
    var language: String?
}

struct FilmProviderRequest {
    static func getFilmListConstants(params: BaseProviderParamsDTO?) -> ProviderDTO {
        return ProviderDTO(params: params?.encode(),
                           method: .get,
                           endpoint: URLEndpoint.filmList)
    }
    
    static func getFilmDetailConstants(params: BaseProviderParamsDTO?, movieId: String) -> ProviderDTO {
        return ProviderDTO(params: params?.encode(),
                           method: .get,
                           endpoint: "\(URLEndpoint.filmDetail)\(movieId)")
    }
}
