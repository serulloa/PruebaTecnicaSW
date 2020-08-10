//
//  NetworkManager.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import Alamofire

/**
 Clase de ayuda para detectar fallos en la conexión a internet del dispositivo
 */
class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
    
    func checkNetwork() -> Bool {
        
        return self.reachabilityManager?.isReachable ?? true
    }
    
    func networkType() -> String {
        
        return NetworkManager.shared.reachabilityManager?.isReachableOnEthernetOrWiFi ?? false
            ? "connection_type_wifi".localized
            : "connection_type_mobile".localized
    }
}
