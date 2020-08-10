//
//  BaseAssembly.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation

/**
 Clase padre de todos los Assemblies, esta clase es utilizada para la inyección de dependencias
 entre las distintas clases de los módulos MVVM
 */
class BaseAssembly {
    
    static func assembly<View: BaseView,
        ViewModel: BaseViewModel>(baseView: View,
                                  viewModel: ViewModel.Type) -> (view: View, viewModel: ViewModel) {
            
        let baseViewModel = ViewModel()
        
        baseView.baseViewModel = baseViewModel
        baseViewModel.baseView = baseView
        
        return (baseView, baseViewModel)
    }
}
