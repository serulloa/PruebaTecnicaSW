//
//  BaseProvider.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 08/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import Alamofire

/**
 Estructura utilizada para transferir información desde los ViewModels a los providers
 */
struct ProviderDTO {
    var params: [String: Any]?
    var arrayParams: [[String: Any]]?
    var method: HTTPMethod
    var endpoint: String
    var acceptType = AcceptResponseType.json

    init(params: [String: Any]?,
         method: HTTPMethod,
         endpoint: String,
         acceptType: AcceptResponseType = .json) {

        self.params = params
        self.method = method
        self.endpoint = endpoint
        self.acceptType = acceptType
    }

    init(arrayParams: [[String: Any]]?,
         method: HTTPMethod,
         endpoint: String,
         acceptType: AcceptResponseType = .json) {

        self.arrayParams = arrayParams
        self.method = method
        self.endpoint = endpoint
        self.acceptType = acceptType
    }
}

/**
 Clase padre de todos los Providers. Realiza las llamadas a la API y se encarga de gestionar la
 recogida de datos y de errores
 */
class BaseProvider: NSObject {
    
    var task: URLSessionTask?
    
    /**
     Realiza el parseo de JSON a un modelo dado
     */
    static func parseToServerModel<Model: BaseModel>(parserModel: Model.Type, data: Data?) -> Model? {

        guard let payload = data, let model = try? JSONDecoder().decode(parserModel, from: payload) else {
            return nil
        }
        return model
    }

    /**
     Realiza el parseo de JSON a un array de modelos dado
     */
    static func parseArrayToServerModel<Model: BaseModel>(parserModel: [Model].Type, data: Data?) -> [Model]? {

        guard let payload = data, let arrayModels = try? JSONDecoder().decode(parserModel, from: payload) else {
            return nil
        }
        return arrayModels
    }
    
    private var manager: Alamofire.SessionManager!
    private func createManager(timeout: TimeInterval) -> Alamofire.SessionManager {

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        let manager = Alamofire.SessionManager(
            configuration: configuration
        )

        return manager
    }
    
    /**
     Función que realiza la llamada a la API.
     */
    internal func request(dto: ProviderDTO,
                          timeout: TimeInterval = 60,
                          loader: Bool = true,
                          printLog: Bool = true,
                          encrypted: Bool = false,
                          additionalHeader: [ String: String] = [:],
                          success: @escaping(Data?) -> Void,
                          failure: @escaping(ErrorType) -> Void) -> URLSessionTask? {

        if !NetworkManager.shared.checkNetwork() {
            failure(ErrorType.networkError)
        }
        
        let baseURL = URLEndpoint.getBaseUrl()
        let endpoint = "\(baseURL)/\(dto.endpoint)"

        var headers: [String: String] = [Constants.contentTypeHeader: Constants.jsonMIMEtype]
        
        let parameters: [String: Any]? = dto.params

        //se añaden nuevas cabeceras si el parametro viene lleno
        if !additionalHeader.isEmpty {
            for item in additionalHeader {
                headers[item.key] = item.value
            }
        }

        // Crea el manager, en la primera ejecución del provider, o cuando el timeout se modifica.
        if self.manager == nil ||
            self.manager.session.configuration.timeoutIntervalForRequest != timeout {

            self.manager = self.createManager(timeout: timeout)
        }

        let request = self.manager.request(endpoint,
                                           method: dto.method,
                                           parameters: parameters,
                                           encoding: self.getEncodingType(dto: dto, encrypted: encrypted),
                                           headers: headers)
        
        request.responseJSON { response in
            
            if (200..<300).contains(response.response?.statusCode ?? 0) {

                // Gestión del caso correcto

                // Se obtiene la respuesta.
                guard let _ = response.data else {
                    // Si la respuesta no tiene datos, se devuelve un error.
                    failure(ErrorType(rawValue: response.response?.statusCode ?? -1) ?? ErrorType.unknownError)
                    return
                }

                let decryptedBytes = self.manageResponseData(data: response.data, encrypted: encrypted, printLog: printLog)

                success(decryptedBytes)

            } else {
                failure(ErrorType(rawValue: response.response?.statusCode ?? -1) ?? ErrorType.unknownError)
                
                return
            }
        }

        self.task = request.task
        return request.task
    }
    
    /**
     Realiza la desencriptación del data obtenido en la llamada
     */
    fileprivate func manageResponseData(data: Data?, encrypted: Bool, printLog: Bool) -> Data? {

        guard let data = data else { return nil }

        var decryptedBytes: Data?

        if encrypted {
            // Desencriptar

        } else {
            decryptedBytes = data
        }

        return decryptedBytes
    }
    
    /**
     Se encarga de obtener el tipo de codificación necesaria para la llamada
     */
    func getEncodingType(dto: ProviderDTO, encrypted: Bool) -> ParameterEncoding {

        switch dto.method {
        case .get, .delete:

            return CustomGetEncoding(encrypted: encrypted)

        case .post, .put, .patch:

            if encrypted && dto.params != nil {

                return CustomGetEncoding(params: dto.params, encrypted: encrypted)
            }

            if !encrypted && dto.params != nil {

                return JSONEncoding.default
            }

            if dto.arrayParams != nil {
                return CustomGetEncoding(arrayParams: dto.arrayParams, encrypted: encrypted)
            }

        default:
            return JSONEncoding.default
        }

        return JSONEncoding.default
    }

    struct CustomGetEncoding: ParameterEncoding {

        var params: [String: Any]?
        var arrayParams: [[String: Any]]?
        var encrypted: Bool

        init(encrypted: Bool) {
            self.encrypted = encrypted
        }

        init(params: [String: Any]?,
             encrypted: Bool) {

            self.params = params
            self.encrypted = encrypted
        }

        init(arrayParams: [[String: Any]]?,
             encrypted: Bool) {

            self.arrayParams = arrayParams
            self.encrypted = encrypted
        }

        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {

            var request = try URLEncoding().encode(urlRequest, with: parameters)

            if let params = self.params, let httpBody = try? JSONSerialization.data(withJSONObject: params) {

                request.httpBody = self.getHTTPBody(data: httpBody, encrypted: encrypted)
            }

            if let arrayParams = self.arrayParams, let httpBody = try? JSONSerialization.data(withJSONObject: arrayParams) {

                request.httpBody = self.getHTTPBody(data: httpBody, encrypted: encrypted)
            }

            request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
            return request
        }

        func getHTTPBody(data: Data, encrypted: Bool) -> Data? {

            if encrypted {
                // Encriptar
                return Data()
            } else {
                return data
            }
        }
    }
    
}
