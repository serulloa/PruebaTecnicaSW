//
//  FilmListAssembly.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 09/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import UIKit

/**
 Clase encargada de la inyección de dependencias del módulo FilmList
 */
final class FilmListAssembly: BaseAssembly {
    static func navigationController(dto: FilmListAssemblyDTO? = nil) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: view(dto: dto))

        return navigationController
    }
    
    static func view(dto: FilmListAssemblyDTO? = nil) -> FilmListViewController {

        let view = FilmListViewController(nibName: Utils.getXib(xibFile: .filmListView), bundle: nil)
        
        let mvvm = BaseAssembly.assembly(baseView: view,
                                          viewModel: FilmListViewModel.self)
        
        mvvm.viewModel.assemblyDTO = dto

        return view
    }
}

struct FilmListAssemblyDTO {
    
}
