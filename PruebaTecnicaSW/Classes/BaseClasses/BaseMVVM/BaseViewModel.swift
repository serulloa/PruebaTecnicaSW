//
//  BaseViewModel.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 08/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/**
 Clase padre de todos los ViewModels MVVM utilizados en el código
 */
class BaseViewModel {
    
    internal var baseView: BaseView?
    
    required init() {}
    
    /**
     Función utilizada para realizar configuraciones iniciales del ViewModel.
     Es llamada por la función viewDidLoad de BaseModel
     */
    func viewDidLoad() {}
    
}
