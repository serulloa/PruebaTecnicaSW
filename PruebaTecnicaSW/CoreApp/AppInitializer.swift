//
//  AppInitializer.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

/**
 Clase utilizada para la inicialización de Pods (si fuese necesario) y para instanciar
 el ViewController principal de la app. También se realizan aquí configuraciones globales
 y se comprueba la seguridad del dispositivo
 */
class AppInitializer: NSObject {
    
    /**
     Función dedicada a realizar cualquier gestión necesaria cuando el usuario se descarga
     la app por primera vez
     */
    func checkIfFirstOpen() {

        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    /**
     Función que instancia el ViewController principal y configura Pods
     */
    func installRootViewController() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        guard let window = UIApplication.shared.delegate?.window else { return }
        window?.rootViewController = FilmListAssembly.navigationController()
        window?.makeKeyAndVisible()
    }
    
    /**
     Comprobaciones de seguridad, entre ellas, si el dispositivo está rooteado
     */
    func passSecurityValidations() -> Bool {
        if UIApplication.shared.isDeviceJailbroken() {
            // do anything
        }

        return !UIApplication.shared.isDeviceJailbroken()
    }
}
