//
//  FilmDetailAssembly.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 10/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import Foundation
import UIKit

/**
 Clase encargada de la inyección de dependencias del módulo FilmDetail
 */
final class FilmDetailAssembly: BaseAssembly {
    static func navigationController(dto: FilmDetailAssemblyDTO? = nil) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: view(dto: dto))

        return navigationController
    }
    
    static func view(dto: FilmDetailAssemblyDTO? = nil) -> FilmDetailViewController {

        let view = FilmDetailViewController(nibName: Utils.getXib(xibFile: .filmDetailView), bundle: nil)
        
        let mvvm = BaseAssembly.assembly(baseView: view,
                                          viewModel: FilmDetailViewModel.self)
        
        mvvm.viewModel.assemblyDTO = dto

        return view
    }
}

struct FilmDetailAssemblyDTO {
    var id: Int?
    var title: String?
}
